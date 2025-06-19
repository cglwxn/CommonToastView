//
//  CorneRadusCreator.swift
//  Memeshot
//
//  Created by cc on 10/2/2025.
//

import UIKit

extension UIView {
    func bezierCornerRadius(rect: CGRect, radius: Double, corners: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]) {
        self.layer.sublayers?.forEach({ layer in
            if let layer = layer as? BezierCornerBackgroundLayer {
                layer.removeFromSuperlayer()
            }
        })
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius)) // 设置圆角半径

        let maskLayer = BezierCornerBackgroundLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    func bezierCornerBorder(rect: CGRect, radius: Double, corners: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight], borderColor: UIColor = UIColor.color(.bordrColor), borderWidth: Double = 1) {
        self.removeCornerBorder()
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius)) // 设置圆角半径

        let shapeLayer = BezierCornerBorderLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = borderColor.cgColor
        shapeLayer.lineWidth = borderWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(shapeLayer)
    }
    
    func removeCornerBorder() {
        self.layer.sublayers?.forEach({ layer in
            if let layer = layer as? BezierCornerBorderLayer {
                layer.removeFromSuperlayer()
            }
        })
    }
}
