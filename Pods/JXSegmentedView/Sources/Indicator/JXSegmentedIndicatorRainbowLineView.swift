//
//  JXSegmentedIndicatorRainbowLineView.swift
//  JXSegmentedView
//
//  Created by jiaxin on 2018/12/28.
//  Copyright © 2018 jiaxin. All rights reserved.
//

import UIKit

/// 会无视indicatorColor属性，以indicatorColors为准
open class JXSegmentedIndicatorRainbowLineView: JXSegmentedIndicatorLineView {
    /// 数量需要与item的数量相等。默认空数组，必须要赋值该属性。segmentedView在reloadData的时候，也要一并更新该属性，不然会出现数组越界。
    open var indicatorColors = [UIColor]()

    override open func refreshIndicatorState(model: JXSegmentedIndicatorSelectedParams) {
        super.refreshIndicatorState(model: model)

        backgroundColor = indicatorColors[model.currentSelectedIndex]
    }

    override open func contentScrollViewDidScroll(model: JXSegmentedIndicatorTransitionParams) {
        super.contentScrollViewDidScroll(model: model)

        guard canHandleTransition(model: model) else {
            return
        }

        backgroundColor = JXSegmentedViewTool.interpolateColor(from: indicatorColors[model.leftIndex], to: indicatorColors[model.rightIndex], percent: model.percent)
    }

    override open func selectItem(model: JXSegmentedIndicatorSelectedParams) {
        super.selectItem(model: model)

        backgroundColor = indicatorColors[model.currentSelectedIndex]
    }
}
