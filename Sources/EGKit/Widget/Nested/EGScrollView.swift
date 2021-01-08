//
//  EGScrollView.swift
//  YouZhiYuan
//
//  Created by youzy01 on 2020/7/29.
//  Copyright © 2020 泽i. All rights reserved.
//

import UIKit

/// 嵌套scrollView，用于嵌套PageView
open class EGScrollView: UIScrollView, UIGestureRecognizerDelegate {
    /// 横向翻页ScrollView, 此view避免 上下、左右滑动同时进行
    public var ignoreViews: [UIView?] = []

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if ignoreViews.contains(otherGestureRecognizer.view) {
            return false
        }
        return true
    }
}
