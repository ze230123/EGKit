//
//  RefreshHeader.swift
//  SwiftPackageDemo
//
//  Created by youzy01 on 2020/9/21.
//  Copyright © 2020 优志愿. All rights reserved.
//

import UIKit

open class RefreshHeader: Refresh {
    /// 刷新状态
    override var state: RefreshState {
        didSet {
            switch state {
            case .none:
                isHidden = true
                if oldValue == .refreshing || oldValue == .finish {
                    stopRefreshing()
                }
//                print("闲置状态")
            case .pulling:
                isHidden = false
//                print("拖拽中")
//            case .ready:
//                print("松开就可以进行刷新的状态")
            case .refreshing:
                isHidden = false
                startRefreshing()
//                print("正在刷新中")
//            case .finish:
//                print("结束刷新（只是结束，控件还在显示）")
//            case .noMoreData:
//                print("没有更多数据")
            default: break
            }

            stateDidChanged()
        }
    }

    /// 刷新控件高度
    open override var height: CGFloat {
        return 60
    }

    var contentInset: UIEdgeInsets = .zero

    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        // 设置刷新控件frame
        if let scrollView = newSuperview as? UIScrollView {
            frame.origin.y = -height
            frame.size.width = scrollView.frame.width
            frame.size.height = height

            contentInset = scrollView.contentInset
        }
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard state != .refreshing && state != .finish else { return }
        let y = scrollView.contentOffset.y + scrollView.inset.top
//        print(y)
        if scrollView.isDragging {
            switch y {
            case 0...CGFloat.greatestFiniteMagnitude: // 上滑
//                print("\(y) -> ", "0...max")
                state = .none
            case let num where num > -height && num < 0: // 开始下拉，但是还没到刷新临界点
//                print("\(y) -> ", "-59...-1")
                state = .pulling
            case let num where num <= -height: // 到达或超过临界点
//                print("\(y) -> ", "min...\(-height)")
                state = .ready
            default:
                break
            }
        } else if state == .ready { // 松手后，如果是准备刷新状态，则开始刷新
//            print("设置状态为: refreshing")
            state = .refreshing
        }
    }

    /// 状态发生改变
    open func stateDidChanged() {}
}

private extension RefreshHeader {
    func startRefreshing() {
        guard let scrollView = superview as? UIScrollView else { return }
//        print("开始刷新动画")
        contentInset = scrollView.contentInset
        let insetTop = contentInset.top + height
        UIView.animate(withDuration: 0.25, animations: {
            scrollView.contentInset.top = insetTop
            scrollView.contentOffset.y = -scrollView.inset.top
        }) { [unowned self] (_) in
            self.completion?()
        }
    }

    func stopRefreshing() {
        guard let scrollView = superview as? UIScrollView else { return }
//        print("结束刷新动画")
        let top = contentInset.top
        UIView.animate(withDuration: 0.25) {
            scrollView.contentInset.top = top
        }
    }
}
