//
//  File.swift
//  
//
//  Created by youzy01 on 2020/9/25.
//

import Foundation
import UIKit

public struct EG<Base> {
    let view: Base

    public init(view: Base) {
        self.view = view
    }
}

protocol Accessorialable {
    var emptyView: ViewEmptyable? { get }
    var errorView: ViewErrorable? { get }
    var loadingView: LoadAnimateable? { get }
    var loadingHud: MBHUD? { get }

    func update(_ errorView: ViewErrorable)
    func update(_ emptyView: ViewEmptyable)
    func update(_ loadingView: LoadAnimateable)
    func update(_ loadingHud: MBHUD)
}

extension EG: Accessorialable where Base: UIView {
    var emptyView: ViewEmptyable? {
        if view.emptyView == nil {
            update(EmptyView())
        }
        return view.emptyView
    }

    var errorView: ViewErrorable? {
        if view.errorView == nil {
            update(ErrorView())
        }
        return view.errorView
    }

    var loadingView: LoadAnimateable? {
        if view.loadingView == nil {
            update(LoadingView())
        }
        return view.loadingView
    }

    var loadingHud: MBHUD? {
        if view.loadingHud == nil {
            update(MBHUD.loading(to: view))
        }
        return view.loadingHud
    }

    /// 更新错误提示view
    /// - Parameter errorView: 错误提示view
    func update(_ errorView: ViewErrorable) {
        errorView.frame = view.bounds
        errorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.errorView = errorView
    }

    /// 更新无数据提示view
    /// - Parameter emptyView: 无数据提示view
    func update(_ emptyView: ViewEmptyable) {
        emptyView.frame = view.bounds
        emptyView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.emptyView = emptyView
    }

    /// 更新全屏加载动画视图
    /// - Parameter loadingView: 全屏加载动画
    func update(_ loadingView: LoadAnimateable) {
        loadingView.frame = view.bounds
        loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.loadingView = loadingView
    }

    /// 更新加载动画Hud
    /// - Parameter loadingHud: 加载动画Hud
    func update(_ loadingHud: MBHUD) {
        view.loadingHud = loadingHud
    }

    public func showError(_ error: NTError) {
        guard let errorView = errorView else { return }
        view.addSubview(errorView)
        errorView.update(error, observer: nil)
    }

    public func showLoading() {
        guard let loadingView = loadingView else { return }
        print("显示全屏刷新动画", loadingView)
        loadingView.start()
        view.addSubview(loadingView)
        loadingView.bringSubviewToFront(view)
    }

    public func hideLoading() {
        print("隐藏全屏刷新动画")
        loadingView?.removeFromSuperview()
    }

    public func showEmpty() {
        guard let emptyView = emptyView else { return }
        view.addSubview(emptyView)
    }

    public func hideEmpty() {
        emptyView?.removeFromSuperview()
    }
}

//public class FZ<Base> where Base: UIView {
//    let view: Base
//
//    public init(view: Base) {
//        self.view = view
//    }
//
//    var emptyView: ViewEmptyable? {
//        if view.emptyView == nil {
//            update(EmptyView())
//        }
//        return view.emptyView
//    }
//
//    var errorView: ViewErrorable? {
//        if view.errorView == nil {
//            update(ErrorView())
//        }
//        return view.errorView
//    }
//
//    var loadingView: LoadAnimateable? {
//        if view.loadingView == nil {
//            update(LoadingView())
//        }
//        return view.loadingView
//    }
//
//    var loadingHud: MBHUD? {
//        if view.loadingHud == nil {
//            update(MBHUD.loading(to: view))
//        }
//        return view.loadingHud
//    }
//
//    /// 更新错误提示view
//    /// - Parameter errorView: 错误提示view
//    public func update(_ errorView: ViewErrorable) {
//        errorView.frame = CGRect(origin: .zero, size: view.bounds.size)
//        errorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.errorView = errorView
//    }
//
//    /// 更新无数据提示view
//    /// - Parameter emptyView: 无数据提示view
//    public func update(_ emptyView: ViewEmptyable) {
//        emptyView.frame = CGRect(origin: .zero, size: view.bounds.size)
//        emptyView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.emptyView = emptyView
//    }
//
//    /// 更新全屏加载动画视图
//    /// - Parameter loadingView: 全屏加载动画
//    public func update(_ loadingView: LoadAnimateable) {
//        loadingView.frame = CGRect(origin: .zero, size: view.bounds.size)
//        loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.loadingView = loadingView
//    }
//
//    /// 更新加载动画Hud
//    /// - Parameter loadingHud: 加载动画Hud
//    public func update(_ loadingHud: MBHUD) {
//        view.loadingHud = loadingHud
//    }
//}
//
//class ListFZ: FZ<UITableView> {
//    override func showError(_ error: NTError) {
//        view.rf.header?.endRefresh()
//        view.rf.footer?.endRefresh()
//        super.showError(error)
//    }
//}
//
//public extension UIView {
//    var fz: FZ<UIView> {
//        return FZ(view: self)
//    }
//}
//// MARK: - view的辅助视图（错误视图、空视图、加载视图、加载hud）
//public extension EG where Base: UIView {
//    var emptyView: ViewEmptyable? {
//        if view.emptyView == nil {
//            update(EmptyView())
//        }
//        return view.emptyView
//    }
//
//    var errorView: ViewErrorable? {
//        if view.errorView == nil {
//            update(ErrorView())
//        }
//        return view.errorView
//    }
//
//    var loadingView: LoadAnimateable? {
//        if view.loadingView == nil {
//            update(LoadingView())
//        }
//        return view.loadingView
//    }
//
//    var loadingHud: MBHUD? {
//        if view.loadingHud == nil {
//            update(MBHUD.loading(to: view))
//        }
//        return view.loadingHud
//    }
//
//    /// 更新错误提示view
//    /// - Parameter errorView: 错误提示view
//    func update(_ errorView: ViewErrorable) {
//        errorView.frame = view.bounds
//        errorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.errorView = errorView
//    }
//
//    /// 更新无数据提示view
//    /// - Parameter emptyView: 无数据提示view
//    func update(_ emptyView: ViewEmptyable) {
//        emptyView.frame = view.bounds
//        emptyView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.emptyView = emptyView
//    }
//
//    /// 更新全屏加载动画视图
//    /// - Parameter loadingView: 全屏加载动画
//    func update(_ loadingView: LoadAnimateable) {
//        loadingView.frame = view.bounds
//        loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.loadingView = loadingView
//    }
//
//    /// 更新加载动画Hud
//    /// - Parameter loadingHud: 加载动画Hud
//    func update(_ loadingHud: MBHUD) {
//        view.loadingHud = loadingHud
//    }
//}
//
//// MARK: - 更新辅助视图（错误视图、空视图、加载视图、加载hud）
//public extension EG {
//}

//// MARK: - Reset
//private extension UIView {
//    /// 重置视图
//    func reset() {
//        if errorView != nil {
//            errorView?.removeFromSuperview()
//        }
//        if emptyView != nil {
//            emptyView?.removeFromSuperview()
//        }
//        if loadingView != nil {
//            loadingView?.stop()
//            loadingView?.removeFromSuperview()
//        }
//        MBHUD.hide(for: self, animated: true)
//    }
//}
//
//extension EG {
//}

//// MARK: - Error
//public extension UIView {
//    /// 显示错误提示
//    /// - Parameter error: 错误
//    func showError(_ error: EGError, style: ErrorStyle, observer: ErrorHandlerObserverType? = nil) {
//        reset()
//        switch style {
//        case .view:
//            guard let errorView = errorView else { return }
//            addSubview(errorView)
//            errorView.update(error, observer: observer)
//        case .hud:
//            MBHUD.showMessage(error.localizedDescription, to: self, delay: 3)
//        }
//    }
//}
//
//// MARK: - Empty
//public extension UIView {
//    /// 显示空数据提示
//    /// - Parameter isEmpty: 是否为空
//    func showEmpty(_ isEmpty: Bool) {
//        reset()
//        guard isEmpty, let empty = emptyView else { return }
//        addSubview(empty)
//    }
//}
//
//// MARK: - Loading
//public extension UIView {
//    /// 显示加载动画
//    /// - Parameters:
//    ///   - style: 动画类型
//    ///   - isEnabled: 是否启用
//    func showLoading(_ style: LoadingStyle, isEnabled: Bool = true) {
//        reset()
//        guard isEnabled else { return }
//        switch style {
//        case .image:
//            showImageLoadingView()
//        case .imageHud:
//            showImageHudLoadingView()
//        case .normalHud:
//            showNormalHud()
//        }
//    }
//
//    /// 停止加载动画
//    func stopLoading() {
//        reset()
//    }
//
//    private func showImageLoadingView() {
//        guard let loadingView = loadingView else { return }
//        loadingView.start()
//        addSubview(loadingView)
//    }
//
//    private func showImageHudLoadingView() {
//        guard let hud = loadingHud else { return }
//        addSubview(hud)
//        hud.show(animated: true)
//    }
//
//    private func showNormalHud() {
//        _ = MBHUD.showCustomAdded(to: self, animated: true)
//    }
//}
