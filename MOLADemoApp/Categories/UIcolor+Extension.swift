//
//  UIcolor+Extension.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/5/19.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(rgb: UInt) {
        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgb & 0x0000FF) / 255.0, alpha: CGFloat(1.0))
    }
    
    convenience init(rgb: UInt, alpha: Float) {
        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgb & 0x0000FF) / 255.0, alpha: CGFloat(alpha))
    }

    class var molaColor: UIColor {
        return UIColor(rgb: 0x369CF6)
    }

    class var normalGaryColor: UIColor {
        return UIColor(rgb: 0x9B9B9B)
    }
    
    class var bgGaryColor: UIColor {
        return UIColor(rgb: 0xF5F5F5)
    }
    
    class var textBlackColor: UIColor {
        return UIColor(rgb: 0x515151)
    }
    
    class var textGaryColor: UIColor {
        return UIColor(rgb: 0x909090)
    }
   
}
