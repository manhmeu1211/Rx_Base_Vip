//
//  IntroDetailView.swift
//  RX_Base_VIP
//
//  Created by Luong Manh on 15/12/2023.
//
import UIKit
import Stevia
import RxSwift
import RxCocoa
import Foundation

class RXVIPIntroDetailView: UIView {
    lazy var imageView = UIImageView().style {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    lazy var titleLabel = UILabel().style {
        $0.textColor = .white
        $0.font = .font(.bold, withSize: .size24)
        $0.textAlignment = .center
        $0.setContentHuggingPriority(.required, for: .vertical)
        $0.setContentCompressionResistancePriority(.required, for: .vertical)
        $0.sizeToFit()
        $0.numberOfLines = 0
    }
    
    lazy var contentLabel = UILabel().style {
        $0.textColor = .white
        $0.font = .font(.regular, withSize: .size18)
        $0.textAlignment = .center
        $0.setContentHuggingPriority(.required, for: .vertical)
        $0.setContentCompressionResistancePriority(.required, for: .vertical)
        $0.sizeToFit()
        $0.numberOfLines = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RXVIPIntroDetailView {
    func createViews() {
        self.subviews {
            imageView
            titleLabel
            contentLabel
        }
    }
    
    func createConstraints() {
        imageView.fillContainer(padding: 0)
        titleLabel.centerHorizontally()
        contentLabel.centerHorizontally()
        contentLabel.Bottom == Bottom - 139
        titleLabel.Bottom == contentLabel.Top - 6
    }
}

extension RXVIPIntroDetailView {
    func observeIndex(index: Int) {
        switch index {
        case 0:
            imageView.image = R.image.bg_intro1()
        case 1:
            imageView.image = R.image.bg_intro2()
        case 2:
            imageView.image = R.image.bg_intro3()
        default:
            imageView.image = R.image.bg_intro4()
        }
    }
}
