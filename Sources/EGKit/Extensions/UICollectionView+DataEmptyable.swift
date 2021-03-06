//
//  UICollectionView+DataEmptyable.swift
//  
//
//  Created by youzy01 on 2020/9/28.
//

import UIKit

extension UICollectionView {
    public func reloadDataIfEmpty(_ type: CheckType = .row) {
        reloadData()
        let isEmpty = dataIsEmpty(type: type)
        if isEmpty {
            eg.showEmpty()
        } else {
            eg.hideEmpty()
        }
    }

    /// 判断是否没有数据
    /// - Parameter type: `CheckType`判断条件
    /// - Returns: `Bool`
    private func dataIsEmpty(type: CheckType) -> Bool {
        switch type {
        case .section:
            return numberOfSections == 0
        case .row:
            return numberOfSections == 1 && numberOfItems(inSection: 0) == 0
        }
    }
}
