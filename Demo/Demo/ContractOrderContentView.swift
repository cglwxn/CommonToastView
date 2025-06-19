//
//  ContractOrderContentView.swift
//  Memeshot
//
//  Created by cc on 30/4/2025.
//

import UIKit
import Kingfisher

class ContractOrderContentView: UIView {
    private var seeOrderClosure: (() -> ())?
    private lazy var effectBackgroundView: UIVisualEffectView = {
        if #available(iOS 13.0, *) {
            let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterialDark))
            return view
        } else {
            let view = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
            return view
        }
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = .font(size: .bigContent, family: .System, weight: .Medium)
        label.textColor = .color(.mainColor)
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
//        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .font(size: .littleContent, family: .System, weight: .Medium)
        label.textColor = .white
        return label
    }()
    
    private lazy var symbolIconImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
//        view.backgroundColor = .color(.mainColor)
        view.layer.cornerRadius = 25
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.color(.bordrColor).cgColor
        return view
    }()
    
    private lazy var longOrShortLabel: UILabel = {
        let label = UILabel()
        label.font = .font(size: .littleContent, family: .System, weight: .Medium)
        label.textColor = .color(.mainColor)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var typeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(size: .littleContent, family: .System)
        label.textColor = .white
        label.text = "Type :"
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = .font(size: .littleContent, family: .System)
        label.textColor = .white
        return label
    }()
    
    private lazy var priceTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(size: .littleContent, family: .System)
        label.textColor = .white
        label.text = "Price :"
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .font(size: .littleContent, family: .System)
        label.textColor = .white
        return label
    }()
    
    private lazy var leverageTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(size: .littleContent, family: .System)
        label.textColor = .white
        label.text = "Leverage :"
        return label
    }()
    
    private lazy var leverageLabel: UILabel = {
        let label = UILabel()
        label.font = .font(size: .littleContent, family: .System)
        label.textColor = .white
        return label
    }()
    
    private lazy var bondTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(size: .littleContent, family: .System)
        label.textColor = .white
        label.text = "Margin :"
        return label
    }()
    
    private lazy var bondLabel: UILabel = {
        let label = UILabel()
        label.font = .font(size: .littleContent, family: .System)
        label.textColor = .white
        return label
    }()
    
    private lazy var seeOrderView: SwitchTradeTypeView = {
        let view = SwitchTradeTypeView(frame: .zero) {[weak self] in
            guard let self = self else { return }
            self.seeOrderClosure?()
        }
//        view.layer.cornerRadius = 10
        view.bezierCornerRadius(rect: CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 60, height: 36), radius: 10)
        view.labelText = "Check order"
        view.labelTextColor = .white
        view.labelFont = .font(size: .littleContent, family: .System, weight: .Medium)
        view.backgroundColor = .brown.withAlphaComponent(0.9)
        view.indicatorImage = "right-indicator"
        return view
    }()
    
    init(longOrShort: String, leverage: String, bond: String, symbol: String, logo: String, type: String, price: String, text: String, success: Bool = true, seeOrderClosure: @escaping (() -> ())) {
        super.init(frame: .zero)
//        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .init(width: 0, height: 0)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.2
        self.setupSbuviews()
        self.setupLayout()
        
        self.longOrShortLabel.text = longOrShort
        self.symbolIconImageView.image = UIImage(named: logo)
        self.symbolLabel.text = symbol
        self.textLabel.textColor = success ? .color(.mainColor) : .color(.redColor)
        self.textLabel.text = text
        self.typeLabel.text = type
        self.priceLabel.text = price
        self.leverageLabel.text = leverage
        self.bondLabel.text = bond
        self.seeOrderClosure = seeOrderClosure
        self.symbolIconImageView.image = UIImage(named: logo)
    }
    
    private func setupSbuviews() {
        self.addSubview(contentView)
        contentView.addSubview(effectBackgroundView)
        effectBackgroundView.contentView.addSubview(symbolIconImageView)
        effectBackgroundView.contentView.addSubview(symbolLabel)
        effectBackgroundView.contentView.addSubview(longOrShortLabel)
        effectBackgroundView.contentView.addSubview(textLabel)
        effectBackgroundView.contentView.addSubview(typeTitleLabel)
        effectBackgroundView.contentView.addSubview(typeLabel)
        effectBackgroundView.contentView.addSubview(priceTitleLabel)
        effectBackgroundView.contentView.addSubview(priceLabel)
        effectBackgroundView.contentView.addSubview(leverageTitleLabel)
        effectBackgroundView.contentView.addSubview(leverageLabel)
        effectBackgroundView.contentView.addSubview(bondTitleLabel)
        effectBackgroundView.contentView.addSubview(bondLabel)
//        effectBackgroundView.contentView.addSubview(seeOrderView)
    }
    private func setupLayout() {
        self.contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.effectBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
                
        self.textLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(15)
        }
        
        self.symbolIconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.top.equalTo(textLabel.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        self.symbolLabel.snp.makeConstraints { make in
            make.leading.equalTo(symbolIconImageView.snp.trailing).offset(10)
            make.centerY.equalTo(symbolIconImageView)
        }
        
        self.longOrShortLabel.snp.makeConstraints { make in
            make.leading.equalTo(symbolLabel.snp.trailing).offset(5)
            make.centerY.equalTo(symbolLabel)
        }
        
        self.typeTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalTo(symbolIconImageView.snp.bottom).offset(10)
        }
        
        self.typeLabel.snp.makeConstraints { make in
            make.leading.equalTo(typeTitleLabel.snp.trailing).offset(5)
            make.centerY.equalTo(typeTitleLabel)
            make.trailing.lessThanOrEqualTo(self.snp.centerX)
        }
        
        self.priceTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.centerX).offset(10)
            make.centerY.equalTo(typeLabel)
        }
        
        self.priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(priceTitleLabel.snp.trailing).offset(5)
            make.centerY.equalTo(priceTitleLabel)
        }
        
        self.leverageTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalTo(typeTitleLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        self.leverageLabel.snp.makeConstraints { make in
            make.leading.equalTo(leverageTitleLabel.snp.trailing).offset(5)
            make.centerY.equalTo(leverageTitleLabel)
        }
        
        self.bondTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.centerX).offset(10)
            make.centerY.equalTo(leverageLabel)
        }
        
        self.bondLabel.snp.makeConstraints { make in
            make.leading.equalTo(bondTitleLabel.snp.trailing).offset(5)
            make.centerY.equalTo(bondTitleLabel)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContractOrderContentView: CommonToastContentView {
    func toastWillDisplay(context: Any?) {
        if context is CommonToastViewDisplayFromDestination {
            self.contentView.layer.cornerRadius = 20
            self.contentView.layer.masksToBounds = true
        }
    }
}


