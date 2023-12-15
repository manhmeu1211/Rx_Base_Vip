// 
//  RXVIPHomeViewController.swift
//  RX_Base_VIP
//
//  Created by Luong Manh on 15/12/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Stevia

class RXVIPHomeViewController: UIViewController {
    let viewModel: RXVIPHomeViewModel
    
    lazy var imageView = UIImageView()

    init(viewModel: RXVIPHomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        setupViews()
        bindViewModel()
    }

    private func bindViewModel() {
        let output = viewModel.transform(input: .init())
    }
}

extension RXVIPHomeViewController {
    private func createViews() {
        view.subviews {
            imageView
        }
        
        imageView.fillHorizontally()
            .top(view.topAnchor)
            .bottom(view.bottomAnchor)
    }

    private func setupViews() {
        imageView.style {
            $0.contentMode = .scaleToFill
            $0.clipsToBounds = true
            $0.image = R.image.bg_home()
        }
    
    }
}
