//
//  BaseCollectionViewController.swift
//  
//
//  Created by youzy01 on 2020/9/17.
//

import UIKit
import EGRefresh

open class BaseCollectionViewController: BaseViewController, Refreshable {
    @IBOutlet open var collectionView: UICollectionView!
    @IBOutlet open var layout: UICollectionViewFlowLayout!

    public var pageIndex: Int = 1

    /// 刷新行为
    public private(set) var action: RefreshAction = .load

    open override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
    }

    /// collection列表此方法无效，请使用`request(action:)`方法
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

    open func request(action: RefreshAction) {
    }

    public override func onReTry() {
        request(action: action)
    }
}

extension BaseCollectionViewController {
    func initCollectionView() {
        if collectionView == nil {
            layout = UICollectionViewFlowLayout()
            collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
            collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(collectionView)
        }
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
    }
}
