//
//  ViewController.swift
//  Demo
//
//  Created by cgl on 2025/6/19.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let toastContent = ContractOrderContentView.init(longOrShort: "short", leverage: "20x", bond: "$30", symbol: "BTC", logo: "btc-icon", type: "Limit", price: "$100000", text: "Order placed successfully") {}
        let toast = CommonToastView.init(contentView: toastContent, displayFrom: .top)
        toast.display()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let alertContent = TopAlertContentView(frame: .zero)
            alertContent.note = "The token is untradable currently."
            let bottomToast = CommonToastView.init(contentView: alertContent, displayFrom: .bottom, horizentalPadding: 40, verticalMargin: 140, canInteractDismiss: false)
            bottomToast.display() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    alertContent.updateLocation()
                    UIView.animate(withDuration: 0.3) {
                        guard alertContent.superview != nil else { return }
                        alertContent.snp.remakeConstraints { make in
                            make.leading.trailing.equalToSuperview().inset(0)
                            make.bottom.equalToSuperview().offset(0)
                            make.width.equalTo(SCREEN_WIDTH)
                        }
                        alertContent.superview?.layoutIfNeeded()
                    } completion: { finished in
                    }
                }
            }
        }
    }
}

