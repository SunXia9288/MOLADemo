//
//  CornerBaseCell.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/1.
//

import Foundation
import UIKit

class CornerBaseCell: UITableViewCell {
    enum Position {
        case solo
        case first
        case middle
        case last
    }
    var position: Position = .middle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setCorners()
    }
    func setCorners() {
        let cornerRadius: CGFloat = 15.0
        switch position {
        case .solo: roundCorners(corners: .allCorners, radius: cornerRadius)
        case .first: roundCorners(corners: [.topLeft, .topRight], radius: cornerRadius)
        case .last: roundCorners(corners: [.bottomLeft, .bottomRight], radius: cornerRadius)
        default: noCornerMask()
        }
    }
}

