//
//  UIView+Extension.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/1.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        if bounds.size.width > 0{
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
    func noCornerMask() {
        layer.mask = nil
    }
}
