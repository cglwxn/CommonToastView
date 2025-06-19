//
//  CommonToastView.swift
//  Memeshot
//
//  Created by cc on 30/4/2025.
//

import UIKit
import SnapKit

//screen size
let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height
let STATUS_BAR_HEIGHT = UIApplication.shared.statusBarFrame.height

protocol CommonToastContentView: UIView {
    func toastWillDisplay(context: Any?)
}

enum CommonToastViewDisplayFromDestination {
    case top
    case bottom
}

class CommonToastView: UIView {
    enum DismissType {
        case spring
        case line
    }
    private var dismissTimer: Timer?
    private var contentView: CommonToastContentView?
    private var destination: CommonToastViewDisplayFromDestination?
    private var horizentalPadding: Double = 15.0
    private var verticalMargin: Double = Constant.verticalMargin
    private var canInteractDismiss = true
    private var completeClosure: (() -> ())?
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.delaysContentTouches = false
        view.contentSize = CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        view.contentInsetAdjustmentBehavior = .never
        view.showsVerticalScrollIndicator = false
        view.isScrollEnabled = self.canInteractDismiss
        view.delegate = self
        return view
    }()
    
    private lazy var scrollViewContentView: UIView = {
        let view = UIView()
        return view
    }()
    
    enum Constant {
        static let verticalMargin = STATUS_BAR_HEIGHT + 20
    }
    
    init(contentView: CommonToastContentView, displayFrom destination: CommonToastViewDisplayFromDestination = .top, horizentalPadding: Double = 15.0, verticalMargin: Double = Constant.verticalMargin, canInteractDismiss: Bool = true) {
        super.init(frame: .zero)
        self.destination = destination
        self.contentView = contentView
        self.horizentalPadding = horizentalPadding
        self.canInteractDismiss = canInteractDismiss
        self.verticalMargin = verticalMargin
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSbuviews(_ inView: UIView? = UIApplication.shared.delegate?.window as? UIView) {
        guard let inView = inView else{
            return
        }
        inView.addSubview(self)
        self.addSubview(scrollView)
        scrollView.addSubview(scrollViewContentView)
        if let contentView = self.contentView {
            scrollViewContentView.addSubview(contentView)
        }
    }
    
    private func setupLayouts() {
        
        self.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollViewContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(SCREEN_HEIGHT + 1)
        }
        
        if let contentView = self.contentView {
            if self.destination == .top {
                contentView.snp.remakeConstraints { make in
                    make.leading.trailing.equalToSuperview().inset(horizentalPadding)
                    make.top.equalToSuperview().offset(verticalMargin)
                    make.width.equalTo(SCREEN_WIDTH - horizentalPadding * 2)
                }
            } else {
                contentView.snp.remakeConstraints { make in
                    make.leading.trailing.equalToSuperview().inset(horizentalPadding)
                    make.bottom.equalToSuperview().offset(-verticalMargin)
                    make.width.equalTo(SCREEN_WIDTH - horizentalPadding * 2)
                }
            }
        }
    }
    
    func display(_ inView: UIView? = UIApplication.shared.delegate?.window as? UIView, completeClosure: (() -> ())? = nil) {
        self.completeClosure = completeClosure
        CommonToastView.clearAllFromSuperview(inView)
        self.setupSbuviews(inView)
        self.setupLayouts()
        self.setTimer()
        self.contentView?.alpha = 0
        self.toastWillDisplay()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.displayContent(inView)
        }
    }
    
    private func displayContent(_ inView: UIView? = UIApplication.shared.delegate?.window as? UIView) {
        if let inView = inView {
            inView.subviews.forEach({ view in
                if let view = view as? CommonToastView, view != self {
                    view.removeFromSuperview()
                }
            })
            
            if let contentView = self.contentView {
                contentView.alpha = 0.7
                if self.destination == .top {
                  contentView.transform = CGAffineTransform(translationX: 0, y: -CGRectGetHeight(contentView.frame) - verticalMargin)
                } else {
                    contentView.transform = CGAffineTransform(translationX: 0, y: CGRectGetHeight(contentView.frame) + verticalMargin)
                }
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
                    contentView.transform = .identity
                    contentView.alpha = 1
                } completion: { finished in
                    self.completeClosure?()
                }
            }
        }
    }
    
    func dismiss(_ dismissType: DismissType = .spring, startPointY: Double? = nil) {
        var start = 0.0
        if let startPointY = startPointY {
            start = startPointY
        } else {
            if let contentView = self.contentView {
                start = verticalMargin + CGRectGetHeight(contentView.frame)
            }
        }
        if let contentView = self.contentView {
            if self.destination == .top {
                contentView.snp.remakeConstraints { make in
                    make.leading.trailing.equalToSuperview().inset(horizentalPadding)
                    make.bottom.equalTo(self.scrollViewContentView.snp.top)
                    make.width.equalTo(SCREEN_WIDTH - horizentalPadding * 2)
                }
                contentView.transform = CGAffineTransform(translationX: 0, y: start)
            } else {
                contentView.snp.remakeConstraints { make in
                    make.leading.trailing.equalToSuperview().inset(horizentalPadding)
                    make.top.equalTo(self.scrollViewContentView.snp.bottom)
                    make.width.equalTo(SCREEN_WIDTH - horizentalPadding * 2)
                }
                contentView.transform = CGAffineTransform(translationX: 0, y: -start)
            }
            
            contentView.alpha = 1
            
            if dismissType == .spring {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
                    if self.destination == .top {
                        contentView.transform = CGAffineTransform(translationX: 0, y: start + 20)
                    } else {
                        contentView.transform = CGAffineTransform(translationX: 0, y: -start - 20)
                    }
                } completion: { finish in
                    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
                        contentView.alpha = 0.7
                        contentView.transform = .identity
                    } completion: { finish in
                        self.removeFromSuperview()
                        self.dismissTimer?.fireDate = .distantFuture
                        self.dismissTimer?.invalidate()
                    }
                }
            } else {
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
                    contentView.alpha = 0.5
                    contentView.transform = .identity
                } completion: { finish in
                    self.removeFromSuperview()
                    self.dismissTimer?.fireDate = .distantFuture
                    self.dismissTimer?.invalidate()
                }
            }
        }
    }
    
    private func toastWillDisplay() {
        if let contentView = self.contentView {
            contentView.toastWillDisplay(context: self.destination)
            if self.destination == .top {
                self.scrollView.contentInset = .init(top: 0, left: 0, bottom: 1000, right: 0)
            } else {
                self.scrollView.contentInset = .init(top: 1000, left: 0, bottom: 0, right: 0)
            }
        }
        self.scrollView.setContentOffset(.zero, animated: false)
    }
    
    @objc private func cancelAction() {
        self.dismiss()
    }
    
    static func clearAllFromSuperview(_ inView: UIView? = UIApplication.shared.delegate?.window as? UIView) {
        if let inView = inView {
            inView.subviews.forEach({ view in
                if view is CommonToastView {
                    view.removeFromSuperview()
                }
            })
        }
    }
    
    private func setTimer() {
        guard self.canInteractDismiss else { return }
        self.dismissTimer = Timer.scheduledTimer(withTimeInterval: 4, repeats: false, block: {[weak self] timer in
            guard let self = self else { return }
            self.dismiss()
        })
        self.startTimer()
    }
    
    private func startTimer() {
        if #available(iOS 15, *) {
            self.dismissTimer?.fireDate = .now + 4
        } else {
            // Fallback on earlier versions
            self.dismissTimer?.fireDate = Date(timeIntervalSinceNow: 4)
        }
    }
    
    private func stopTimer() {
        self.dismissTimer?.fireDate = .distantFuture
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let contentView = self.contentView {
            if point.y > CGRectGetMaxY(contentView.frame) || point.y < CGRectGetMinY(contentView.frame) {
                return nil
            } else {
                return super.hitTest(point, with: event)
            }
        } else {
            return super.hitTest(point, with: event)
        }
    }
}

extension CommonToastView: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.stopTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > 0 {
            if let contentView = self.contentView {
                self.dismiss(.line, startPointY: verticalMargin + CGRectGetHeight(contentView.frame) - abs(scrollView.contentOffset.y))
            } else {
                self.startTimer()
            }
        } else {
            self.startTimer()
        }
    }
}
