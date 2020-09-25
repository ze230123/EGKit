//
//  File.swift
//  
//
//  Created by youzy01 on 2020/9/25.
//

import UIKit

public struct EG {
    let view: UIView

    public init(view: UIView) {
        self.view = view
    }
}

// MARK: - view的辅助视图（错误视图、空视图、加载视图、加载hud）
public extension EG {
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
}

// MARK: - 更新辅助视图（错误视图、空视图、加载视图、加载hud）
public extension EG {
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
}

// MARK: - Reset
private extension UIView {
    /// 重置视图
    func reset() {
        if errorView != nil {
            errorView?.removeFromSuperview()
        }
        if emptyView != nil {
            emptyView?.removeFromSuperview()
        }
        if loadingView != nil {
            loadingView?.stop()
            loadingView?.removeFromSuperview()
        }
        MBHUD.hide(for: self, animated: true)
    }
}

extension EG {
}

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
