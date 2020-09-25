//
//  UIView+Error.swift
//  
//
//  Created by youzy01 on 2020/9/17.
//

import UIKit
import EGServer
import MBProgressHUD

typealias EGError = ServerError

private struct Keys {
    static var empty = "empty"
    static var error = "error"
    static var loading = "loading"
    static var imageHud = "imageHud"
}

extension UIView {
    public enum LoadingStyle {
        /// 图片动画(全屏)
        case image
        /// 图片动画(缩略图)
        case imageHud
        /// 默认菊花
        case normalHud

        static func random() -> LoadingStyle {
            let arr: [LoadingStyle] = [.image, .imageHud, .normalHud]
            return arr.randomElement()!
        }
    }

    public enum ErrorStyle {
        case view
        case hud
    }
}

// MARK: - 私有存储，runtime添加
extension UIView {
    /// 错误提示View
    var errorView: ViewErrorable? {
        set {
            objc_setAssociatedObject(self, &Keys.error, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return objc_getAssociatedObject(self, &Keys.error) as? ViewErrorable
        }
    }

    /// 无数据页面提示View
    var emptyView: ViewEmptyable? {
        set {
            objc_setAssociatedObject(self, &Keys.empty, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return objc_getAssociatedObject(self, &Keys.empty) as? ViewEmptyable
        }
    }

    /// 加载动画View
    var loadingView: LoadAnimateable? {
        set {
            objc_setAssociatedObject(self, &Keys.loading, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return objc_getAssociatedObject(self, &Keys.loading) as? LoadAnimateable
        }
    }

    /// 加载hud动画
    var loadingHud: MBHUD? {
        set {
            objc_setAssociatedObject(self, &Keys.imageHud, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return objc_getAssociatedObject(self, &Keys.imageHud) as? MBHUD
        }
    }
}

//// MARK: - 更新视图 function
//public extension UIView {
//
//    /// 更新空视图标题
//    ///
//    /// 在`viewDidLoad()`方法中调用
//    ///
//    /// - Parameter title: 标题
//    func updateEmptyTitle(_ title: String) {
//        emptyView?.updateTitle(title)
//    }
//
//    /// 更新空视图内容
//    ///
//    /// 在`viewDidLoad()`方法中调用
//    ///
//    /// - Parameter content: 内容
//    func updateEmptyContent(_ content: String) {
//        emptyView?.updateContent(content)
//    }
//}
