//
//  JXSegmentedTitleGradientItemModel.swift
//  JXSegmentedView
//
//  Created by jiaxin on 2019/1/23.
//  Copyright © 2019 jiaxin. All rights reserved.
//

import UIKit

open class JXSegmentedTitleGradientItemModel: JXSegmentedTitleItemModel {
    open var titleNormalGradientColors = [CGColor]()
    open var titleCurrentGradientColors = [CGColor]()
    open var titleSelectedGradientColors = [CGColor]()
    open var titleGradientStartPoint = CGPoint.zero
    open var titleGradientEndPoint = CGPoint.zero
}
