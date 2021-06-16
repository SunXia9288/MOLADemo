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
    
    convenience init(r:UInt, g:UInt, b:UInt, a:UInt) {
        self.init(red: CGFloat(Double(r) / 255.0), green: CGFloat(Double(g) / 255.0), blue: CGFloat(Double(r) / 255.0), alpha: CGFloat(a))
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
    
    class var pitchGreenColor: UIColor {
        return UIColor(rgb: 0x6FB651)
    }
    
    //分割线颜色
    class var segmentationColor: UIColor {
        return UIColor(rgb: 0xE6E6E6)
    }

    //随机色颜色
    class var randomColor: UIColor {
        return UIColor(r: UInt(arc4random_uniform(256)), g: UInt(arc4random_uniform(256)), b: UInt(arc4random_uniform(256)), a: 1)
        
    }

}
