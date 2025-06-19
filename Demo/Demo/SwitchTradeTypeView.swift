//
//  SwitchPriceButton.swift
//  Memeshot
//
//  Created by cc on 10/12/2024.
//

import UIKit
import SnapKit

class SwitchTradeTypeView: UIView {
    private var accountTappedClosure: (() -> ())?
    
    var labelText: String = "" {
        didSet {
            label.text = labelText
        }
    }
    
    var labelTextColor: UIColor = .black {
        didSet {
            label.textColor = labelTextColor
        }
    }
    
    var labelFont: UIFont = .font(size: .mediumContent, family: .System, weight: .Regular) {
        didSet {
            label.font = labelFont
        }
    }
    
    var indicatorImage: String = "down-arrow-icon" {
        didSet {
            let image = UIImage(named: indicatorImage)?.withRenderingMode(.alwaysTemplate)
            indicatorImageView.image = image
            indicatorImageView.tintColor = .white
            indicatorImageView.snp.remakeConstraints { make in
                make.centerY.equalTo(label)
                make.trailing.equalToSuperview().offset(-16)
                make.width.equalTo(image?.size.width ?? 6)
                make.height.equalTo(image?.size.height ?? 11)
            }
        }
    }
    
    private lazy var label: UILabel = {
        let label = UILabel.init()
        label.textColor = .color(.black)
        label.text = "Market"
        label.font = UIFont.font(size: .mediumContent, family: .System, weight: .Regular)
        return label
    }()
    
    var hideDownIcon: Bool = false {
        didSet {
            self.indicatorImageView.isHidden = hideDownIcon
        }
    }
    
    private lazy var indicatorImageView = {
        let imageView = UIImageView(image: UIImage(named: "down-arrow-icon"))
        return imageView
    }()
    
    init(frame: CGRect,  accountTappedClosure: @escaping (() -> ())) {
        super.init(frame: frame)
        self.accountTappedClosure = accountTappedClosure
        setupSubviews()
        setupLayouts()
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(accountAction))
        self.addGestureRecognizer(tapGes)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(label)
        addSubview(indicatorImageView)
    }
    
    private func setupLayouts() {
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        
        indicatorImageView.snp.makeConstraints { make in
            make.centerY.equalTo(label)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
    }
    
    @objc private func accountAction() {
        self.accountTappedClosure?()
    }
}




