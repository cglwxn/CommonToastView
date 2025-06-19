//
//  TopAlertContentView.swift
//  Memeshot
//
//  Created by cgl on 2025/6/10.
//

import UIKit
import Lottie

class TopAlertContentView: UIView {
  
  var note: String = "" {
    didSet {
      let space: CGFloat = 0.2
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.lineSpacing = 5
      paragraphStyle.alignment = .left
      let attributes: [NSAttributedString.Key: Any] = [
          .paragraphStyle: paragraphStyle,
          .kern: space,
      ]
      let attrString = NSMutableAttributedString(string: note, attributes: attributes)
      noteLabel.attributedText = attrString
    }
  }
  
  private var alertIcon: UIImageView = {
    let view = UIImageView()
    let configuration = UIImage.SymbolConfiguration(pointSize: 16, weight: .medium)
    let image = UIImage(systemName: "exclamationmark.circle", withConfiguration: configuration)
    view.image = image
    view.tintColor = .color(.redColor)
    return view
  }()
  
  private lazy var alertAnimationView: LottieAnimationView = {
      let view = LottieAnimationView(name: "animation-alert" )
      view.loopMode = .loop
      return view
  }()
  
  private lazy var effectBackgroundView: UIVisualEffectView = {
      if #available(iOS 13.0, *) {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
          return view
      } else {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
          return view
      }
  }()
  
  private var noteContainerView: UIView = {
    let view = UIView()
    return view
  }()
  
  private var noteLabel: UILabel = {
    let label = UILabel()
    label.textColor = .color(.redColor)
    label.numberOfLines = 0
    label.textAlignment = .left
    label.font = .font(size: .content, family: .PingFangSC, weight: .Medium)
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    self.setupsubviews()
    self.setupLayout()
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOffset = .init(width: 0, height: 1)
    self.layer.shadowRadius = 10
    self.layer.shadowOpacity = 0.2
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      self.alertAnimationView.play()
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupsubviews() {
    self.addSubview(noteContainerView)
    noteContainerView.addSubview(effectBackgroundView)
//    effectBackgroundView.contentView.addSubview(alertIcon)
    effectBackgroundView.contentView.addSubview(alertAnimationView)
    effectBackgroundView.contentView.addSubview(noteLabel)
  }
  
  private func setupLayout() {
    
    noteContainerView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    effectBackgroundView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
//    alertIcon.snp.makeConstraints { make in
//      make.leading.top.equalToSuperview().offset(15)
//    }
    
    alertAnimationView.snp.makeConstraints { make in
//      make.centerY.equalToSuperview()
      make.leading.equalToSuperview().offset(15)
      make.centerY.equalTo(noteLabel)
      make.size.equalTo(CGSize(width: 35, height: 35))
    }
    
    noteLabel.snp.makeConstraints { make in
      make.leading.equalTo(alertAnimationView.snp.trailing).offset(8)
      make.trailing.equalToSuperview().offset(-15)
      make.top.bottom.equalToSuperview().inset(15)
    }
  }
    
    func updateLocation() {
        UIView.animate(withDuration: 0.3) {
            self.noteLabel.snp.updateConstraints { make in
                make.bottom.equalToSuperview().offset(-98)
                make.trailing.equalToSuperview().offset(-30)
            }
            
            self.alertAnimationView.snp.updateConstraints { make in
              make.leading.equalToSuperview().offset(30)
            }
            self.noteContainerView.layer.cornerRadius = 40
            self.effectBackgroundView.contentView.backgroundColor = .color(.lightYello)
//            self.noteLabel.textColor = .white
//            self.layer.shadowColor = UIColor.clear.cgColor
//            self.layer.shadowOffset = .init(width: 0, height: 1)
//            self.layer.shadowRadius = 10
//            self.layer.shadowOpacity = 0.2
            self.layoutIfNeeded()
        }
    }
}

extension TopAlertContentView: CommonToastContentView {
    func toastWillDisplay(context: Any?) {
        if context is CommonToastViewDisplayFromDestination {
          self.noteContainerView.layer.cornerRadius = 20
          self.noteContainerView.layer.masksToBounds = true
        }
    }
}
