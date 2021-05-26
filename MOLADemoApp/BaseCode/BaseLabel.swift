//
//  BaseLabel.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/5/24.
//

import UIKit

class BaseLabel: UILabel {
    
    let insets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    override func drawText(in rect: CGRect) {
       
        super.drawText(in: rect.inset(by: insets))
    }
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var rect = super .textRect(forBounds: bounds.inset(by: insets), limitedToNumberOfLines: numberOfLines)
        rect.origin.x -= insets.left
        rect.origin.y -= insets.top
        rect.size.width += insets.left + insets.right
        rect.size.height += insets.top + insets.bottom
        return rect
    }
}
