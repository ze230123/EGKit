//
//  NestedScrollManager.swift
//  YouZhiYuan
//
//  Created by youzy01 on 2020/7/30.
//  Copyright © 2020 泽i. All rights reserved.
//

import UIKit

/// 嵌套视图滚动管理（用于顶部有头视图的情况）
open class NestedScrollManager {
    /// 主视图
    private var mainScrollView: EGScrollView
    /// 头视图
    private var headerView: UIView
    
    // 头部视图与子视图之间预留间距
    public var betweenHeight: CGFloat = 0
    /// 子视图
    private var childScrollView: UIScrollView?
    /// 主视图滚动观察
    private var mainScrollViewObservation: NSKeyValueObservation?
    /// 子视图滚动观察
    private var childScrollViewObservation: NSKeyValueObservation?

    deinit {
        mainScrollViewObservation = nil
        childScrollViewObservation = nil
    }

    /// 初始化
    /// - Parameters:
    ///   - mainScrollView: 嵌套最外层ScrollView
    ///   - headerView: 头视图
    ///   - ignoreView: 横向滑动ScrollView，手势穿透时需要忽略，防止垂直、横向同时滑动
    public init(mainScrollView: EGScrollView, headerView: UIView, ignoreView: [UIView?]) {
        mainScrollView.eg_isCanScroll = true
        mainScrollView.ignoreViews = ignoreView

        self.mainScrollView = mainScrollView
        self.headerView = headerView

        setupMainScrollViewObservation()
    }

    public func willDisplayChildScrollView(_ scrollView: UIScrollView?) {
        // 如果主视图滚动位置y小于头视图高度，说明头视图位置已经进入视线
        // 将子视图滚动位置归零
        if mainScrollView.contentOffset.y < headerView.frame.height - betweenHeight {
            scrollView?.contentOffset = .zero
            scrollView?.eg_isCanScroll = false
        }
    }

    public func didDisplayChildScrollView(_ scrollView: UIScrollView?) {
        childScrollView = scrollView
        setupChildScrollViewObservation()
    }
}

private extension NestedScrollManager {
    // 添加主视图滚动观察
    func setupMainScrollViewObservation() {
        mainScrollViewObservation = mainScrollView.observe(\.contentOffset, options: [.new, .old], changeHandler: { [weak self] (scrollView, change) in
            guard let self = self, change.newValue != change.oldValue else {
                return
            }
            self.mainScrollViewDidScroll(scrollView)
        })
    }
    // 添加子视图滚动观察
    func setupChildScrollViewObservation() {
        childScrollViewObservation?.invalidate()
        let keyValueObservation = childScrollView?.observe(\.contentOffset, options: [.new, .old], changeHandler: { [weak self] (scrollView, change) in
            guard let self = self, change.newValue != change.oldValue else {
                return
            }
            self.childScrollViewDidScroll(scrollView)
        })
        childScrollViewObservation = keyValueObservation
    }
}

private extension NestedScrollManager {
    func mainScrollViewDidScroll(_ scrollView: UIScrollView) {
        // 主视图不能滚动
        // 将主视图固定在头视图底部位置，就是segment在顶部
        // 设置子视图可以滚动
        if !scrollView.eg_isCanScroll {
            scrollView.contentOffset.y = headerView.frame.height - betweenHeight
            childScrollView?.eg_isCanScroll = true
        } else {
            // 主视图能滚动
            // 如果主视图滚动位置大于头视图
            // 将主视图固定在头视图底部位置，就是segment在顶部
            // 设置主视图不能滚动
            // 设置子视图可以滚动
            if scrollView.contentOffset.y >= headerView.frame.height - betweenHeight {
                scrollView.contentOffset.y = headerView.frame.height - betweenHeight
                mainScrollView.eg_isCanScroll = false
                childScrollView?.eg_isCanScroll = true
            }
        }
    }

    func childScrollViewDidScroll(_ scrollView: UIScrollView) {
        // 子视图不能滚动
        // 将子视图固定到顶部
        if !scrollView.eg_isCanScroll {
            scrollView.contentOffset.y = 0
        } else {
            // 子视图可以滚动
            // 如果子视图滚动到顶部
            // 设置子视图不可滚动
            // 设置主视图可以滚动
            if scrollView.contentOffset.y <= 0 {
                scrollView.eg_isCanScroll = false
                mainScrollView.eg_isCanScroll = true
            }
        }
    }
}

private var key = "eg_isCanScroll"

private extension UIScrollView {
    // 能否滚动
    var eg_isCanScroll: Bool {
        get {
            return (objc_getAssociatedObject(self, &key) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
