//
//  BaseCollectionViewController.swift
//  
//
//  Created by youzy01 on 2020/9/17.
//

import UIKit
import EGRefresh

open class BaseCollectionViewController: BaseViewController, Refreshable {
    @IBOutlet public weak var collectionView: UICollectionView!

    public var pageIndex: Int = 1

    /// 刷新行为
    private(set) var action: RefreshAction = .load

    open override func viewDidLoad() {
        super.viewDidLoad()
    }

    /// collection列表此方法无效，请使用`request(action:)`方法
    final public override func request() {
    }

    /// 将要调用网络请求
    ///
    /// `loadData()`、`moreData()`方法会调用`willRequest(action:)`
    /// 对`action`赋值、一遍在其他地方使用
    final func willRequest(action: RefreshAction) {
        self.action = action
        request(action: action)
    }

    func request(action: RefreshAction) {
    }

    public override func onReTry() {
        request(action: action)
    }
}
