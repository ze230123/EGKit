//
//  File.swift
//
//
//  Created by youzy01 on 2020/10/23.
//

import UIKit

/// 用于多个滚动视图垂直排列，联动的页面
///
/// 子视图必须使用`xib`初始化
open class BaseStackViewController: BaseViewController, Refreshable {
    @IBOutlet open var stackView: EGStackView!

    public var pageIndex: Int = 1

    /// 刷新行为
    public private(set) var action: RefreshAction = .load

    /// table列表此方法无效，请使用`request(action:)`方法
    final public override func request() {
        fatalError("请使用`request(action:)`方法")
    }

    /// 将要调用网络请求
    ///
    /// `loadData()`、`moreData()`方法会调用`willRequest(action:)`
    /// 对`action`赋值、一遍在其他地方使用
    final func willRequest(action: RefreshAction) {
        self.action = action
        request(action: action)
    }

    /// 请求网络
    ///
    /// - Parameter action: 行为：加载/更多, 具体细节查看`RefreshAction`
    open func request(action: RefreshAction) {
    }

    public override func onReTry() {
        request(action: action)
    }
}
