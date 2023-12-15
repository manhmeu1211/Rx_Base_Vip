//
//  IntroViewController.swift
//
//  Created by Luong Manh on 15/12/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Stevia
import Foundation

class RXVIPIntroViewController: UIViewController {
    
    let viewModel: RXVIPIntroViewModel
    private let disposeBag = DisposeBag()
    private let indexPages: [Int] = [0, 1, 2, 3]
    private let currentIndex = BehaviorRelay<Int>(value: 0)
    
    lazy var safeAreaView: UIView = {
        let uiview = UIView()
        return uiview
    }()
    
    lazy var pageControl: UIPageControl = {
        let pgControl = UIPageControl()
        pgControl.style {
            $0.sizeToFit()
            $0.numberOfPages = indexPages.count
            $0.pageIndicatorTintColor = R.color.grey130()
            $0.currentPageIndicatorTintColor = R.color.accentColor()
            $0.isUserInteractionEnabled = false
            $0.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            $0.alpha = 1
        }
        return pgControl
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.style {
            $0.layer.cornerRadius = 20
            $0.setTitle(R.string.localizable.intro_next_button(), for: .normal)
            $0.setTitleColor(R.color.greyBlack(), for: .normal)
            $0.backgroundColor = R.color.accentColor()
            $0.titleLabel?.font = .font(.bold, withSize: .size18)
        }
        return button
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.style {
            $0.delegate = self
            $0.isPagingEnabled = true
            $0.contentSize = CGSize(
                width: view.frame.width * CGFloat(indexPages.count),
                height: scrollView.frame.height
            )
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.contentInsetAdjustmentBehavior = .never
        }
        return scrollView
    }()
    
    lazy var scrollContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.style {
            $0.axis = .horizontal
            $0.alignment = .fill
        }
        return stackView
    }()
    
    init(viewModel: RXVIPIntroViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraint()
        setupScrollView()
        bindViewModel()
    }
    
    private func setupView() {
        view.backgroundColor = .black
        
        view.subviews {
            safeAreaView
            scrollView
                .subviews {
                scrollContentStackView
            }
            pageControl
            nextButton
        }
    }
    
    private func setupConstraint() {
        nextButton
            .height(44)
            .fillHorizontally(padding: 85)
            .bottom(65)
        
        scrollView.fillHorizontally()
        scrollView.Top == view.Top
        scrollView.Bottom == view.Bottom
        
        pageControl.centerHorizontally()
        pageControl.Bottom == nextButton.Top
        
        safeAreaView.fillContainer()

        scrollContentStackView.fillContainer()
        scrollContentStackView.Height == scrollView.Height
    }
    
    private func bindViewModel() {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriver(onErrorJustReturn: ())
        
        let nextButtonPressed = nextButton.rx.tap.debounce(RxTimeInterval.milliseconds(200),
                                                           scheduler: MainScheduler.instance)
            .asDriverOnErrorJustComplete()
        
        let currentIndex = self.currentIndex
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: 0)
        
        let input = RXVIPIntroViewModel.Input(
            loadTrigger: viewWillAppear,
            nextButtonTrigger: nextButtonPressed,
            didScrollToPageIndex: currentIndex)
        
        let output = viewModel.transform(input: input)
        
        output.nextPageTrigger
            .drive(onNext: {[weak self] in
                self?.gotoNextPage()
            })
            .disposed(by: disposeBag)
        
        output.pushable
            .drive(onNext: { [weak self] pushable in
                self?.gotoNextViewController(pushable.makeViewController())
            })
            .disposed(by: disposeBag)
    }
}

extension RXVIPIntroViewController {
    func gotoNextViewController(_ viewController: UIViewController) {
        guard let navigationController = self.navigationController
        else { return }
        navigationController.setViewControllers([viewController], animated: true)
    }
}

extension RXVIPIntroViewController {
    func gotoNextPage() {
        guard scrollView.contentOffset.x < self.view.bounds.width * CGFloat(indexPages.count - 1)
        else { return }
        var contentOffset = scrollView.contentOffset
        contentOffset.x += safeAreaView.frame.width
        scrollView.setContentOffset(contentOffset, animated: true)
    }
    
    func setupScrollView() {
        for index in indexPages {
            addSubviewScrollView(index: index)
        }
    }
    
    func addSubviewScrollView(index: Int) {
        let tutorialView = RXVIPIntroDetailView()
        tutorialView.observeIndex(index: index)
        tutorialView.translatesAutoresizingMaskIntoConstraints = false

        scrollContentStackView.addArrangedSubview(tutorialView)
        tutorialView.Width == safeAreaView.Width
        tutorialView.Height == safeAreaView.Height
    }
}

extension RXVIPIntroViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        let index = Int(pageIndex)
        currentIndex.accept(index)
    }
}

extension RXVIPIntroViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height)
    }
}
