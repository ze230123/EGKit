//
//  UICollectionView+Refresh.swift
//  
//
//  Created by youzy01 on 2020/9/17.
//

import UIKit
import EGRefresh

public extension UICollectionView {
    /// 停止 `下拉刷新`/`上拉加载`
    /// - Parameters:
    ///   - action: `RefreshAction`刷新动作
    ///   - isNotData: 是否没有数据
    func endRefresh(_ action: RefreshAction, isNotData: Bool) {
        rf.endRefresh(action: action, isNotData: isNotData)
    }

    func endRefresh(_ action: RefreshAction, error: Error) {
        rf.endRefresh(action: action, error: error)
    }

    enum CheckType {
        case section
        case row
    }
}
