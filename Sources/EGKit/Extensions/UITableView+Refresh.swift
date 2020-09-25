//
//  UITableView+Refresh.swift
//  
//
//  Created by youzy01 on 2020/9/17.
//

import UIKit
import EGRefresh

public extension UITableView {
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

    /// 重新加载数据并检查数据是否为空
    func reloadDataAndCheckEmpty(type: CheckType = .row) {
        reloadData()
        let isEmpty = isEmptyData(type: type)
//        showEmpty(isEmpty)
    }

    /// 判断是否没有数据
    /// - Parameter type: `CheckType`判断条件
    /// - Returns: `Bool`
    private func isEmptyData(type: CheckType) -> Bool {
        switch type {
        case .section:
            return numberOfSections == 0
        case .row:
            return numberOfSections == 1 && numberOfRows(inSection: 0) == 0
        }
    }

    enum CheckType {
        case section
        case row
    }
}
