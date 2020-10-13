//
//  Refresh.swift
//
//
//  Created by youzy01 on 2020/9/18.
//

import UIKit

struct KVO {
    static let offsetKeyPath = "contentOffset"
    static let contentSizeKeyPath = "contentSize"
}

/// 刷新基类
open class Refresh: UIView {
    public typealias Completion = () -> Void
    /// 刷新控件状态
    var state: RefreshState = .none
    /// 刷新控件高度
    open var height: CGFloat {
        return frame.height
    }

    let completion: Completion?

    deinit {
        print("\(type(of: self))_deinit_state: \(state)")
        removeObservation()
    }

    public var image: UIImage?

    public init(completion: Completion?) {
        image = UIImage(named: "arrow")
        self.completion = completion
        super.init(frame: .zero)
        prepare()
    }

    private override init(frame: CGRect) {
        completion = {}
        super.init(frame: frame)
        prepare()
    }

    required public init?(coder: NSCoder) {
        completion = {}
        super.init(coder: coder)
        prepare()
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        if state == .willRefresh {
            state = .refreshing
        }
    }

    /// 控件添加到父视图时，如果父视图是`UIScrollView`，设置控件的frame，并添加`UIScrollView`观察者
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)

        removeObservation()
        DispatchQueue.main.async { [weak self, newSuperview] in
            self?.addObservation(view: newSuperview)
        }
    }

    final public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let scrollView = superview as? UIScrollView else { return }
        switch keyPath {
        case KVO.offsetKeyPath:
            scrollViewDidScroll(scrollView)
        case KVO.contentSizeKeyPath:
            scrollViewContentSizeDidChange(scrollView)
        default: break
        }
//        if keyPath == KVO.offsetKeyPath {
//            scrollViewDidScroll(scrollView)
//        } else if keyPath == KVO.contentSizeKeyPath {
//            scrollViewContentSizeDidChange(scrollView)
//        }
    }

    func prepare() {}

    /// 开始刷新动画已经结束
    func startAnimationDidEnd() {}
    /// 停止刷新动画已经结束
    func stopAnimationDidEnd() {}

    func scrollViewDidScroll(_ scrollView: UIScrollView) {}
    func scrollViewContentSizeDidChange(_ scrollView: UIScrollView) {}

    /// 停止刷新并提示错误，提示在子类实现
    /// - Parameter error: 错误
    public func endRefresh(error: Error) {
        endRefresh()
    }
}

private extension Refresh {
    func addObservation(view: UIView?) {
        if let scrollView = view as? UIScrollView {
            scrollView.addObserver(self, forKeyPath: KVO.offsetKeyPath, options: [.initial, .new], context: nil)
            scrollView.addObserver(self, forKeyPath: KVO.contentSizeKeyPath, options: [.initial, .new], context: nil)
        }
    }

    func removeObservation() {
        if let scrollView = superview as? UIScrollView {
            scrollView.removeObserver(self, forKeyPath: KVO.offsetKeyPath)
            scrollView.removeObserver(self, forKeyPath: KVO.contentSizeKeyPath)
        }
    }
}

public extension Refresh {
    /// 停止刷新
    func endRefresh() {
//        DispatchQueue.main.async { [unowned self] in
            self.state = .none
//        }
    }

    /// 开始刷新
    func beginRefresh() {
        if window != nil {
            state = .refreshing
        } else {
            if state != .refreshing {
                state = .willRefresh
            }
        }
    }
}
