//
//  RefreshFooter.swift
//  SwiftPackageDemo
//
//  Created by youzy01 on 2020/9/23.
//  Copyright © 2020 优志愿. All rights reserved.
//

import UIKit

open class RefreshFooter: Refresh {
    override var state: RefreshState {
        didSet {
            switch state {
            case .refreshing:
                startRefreshing()
            default:
                break
            }
            stateDidChanged()
        }
    }

    open override var height: CGFloat {
        return 60
    }

    open override var isHidden: Bool {
        didSet {
            guard let scrollView = superview as? UIScrollView else { return }
            guard oldValue != isHidden else { return }
            var bottom = scrollView.contentInset.bottom
            if isHidden == true {
                bottom -= height
            } else {
                bottom += height
            }
            scrollView.contentInset.bottom = bottom
        }
    }

    override func prepare() {
        backgroundColor = .orange
    }

    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)

        if let scrollView = newSuperview as? UIScrollView {
            frame.origin.y = scrollView.contentSize.height
            frame.size.width = scrollView.frame.width
            frame.size.height = height
            // 如果上拉刷新控件是隐藏的就不设置scrollview的bottom
            if !isHidden {
                scrollView.contentInset.bottom += height
            }
        }
    }

    override func scrollViewContentSizeDidChange(_ scrollView: UIScrollView) {
        frame.origin.y = scrollView.contentSize.height
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard state != .refreshing && state != .noMoreData && state != .finish && !isHidden else { return }

        if scrollView.contentSize.height + scrollView.contentInset.top > scrollView.bounds.size.height {
            // 内容超过一个屏幕 计算公式，判断是不是在拖在到了底部
            if scrollView.contentSize.height - scrollView.contentOffset.y + scrollView.contentInset.bottom  <= scrollView.bounds.size.height {
                state = .refreshing
            }
        }
    }

    open func stateDidChanged() {}

    public func endRefreshForNoMoreData() {
        state = .noMoreData
    }

    public func resetRefresh() {
        state = .none
    }
}

private extension RefreshFooter {
    func startRefreshing() {
        guard let scrollView = superview as? UIScrollView else { return }
//        print("开始上拉加载动画")
        let x = scrollView.contentOffset.x
        let y = max(0.0, scrollView.contentSize.height - scrollView.bounds.size.height + scrollView.inset.bottom)

        // Call handler
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveLinear, animations: {
            scrollView.contentOffset = CGPoint.init(x: x, y: y)
        }, completion: { (animated) in
            self.completion?()
        })
    }
}
