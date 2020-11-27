//
//  File.swift
//  
//
//  Created by youzy01 on 2020/9/27.
//

import UIKit

extension UITableView {
    public func reloadDataIfEmpty(_ type: CheckType = .row, isShowHeader: Bool = false) {
        reloadData()
        let isEmpty = dataIsEmpty(type: type)
        if isEmpty {
            eg.showEmpty(at: emptyRect(isShowHeader))
        } else {
            eg.hideEmpty()
        }
    }

    private func emptyRect(_ isShowHeader: Bool) -> CGRect {
        var y = tableHeaderView?.frame.maxY ?? 0

        if isShowHeader {
            if let height = delegate?.tableView?(self, heightForHeaderInSection: 0) {
                y += height
            } else {
                y += sectionHeaderHeight
            }
        }

        let h: CGFloat = bounds.height - y
//        if let value = height {
//            h = value
//        }
        return CGRect(x: 0, y: y, width: bounds.width, height: h)
    }

    /// 判断是否没有数据
    /// - Parameter type: `CheckType`判断条件
    /// - Returns: `Bool`
    private func dataIsEmpty(type: CheckType) -> Bool {
        switch type {
        case .section:
            return numberOfSections == 0
        case .row:
            return numberOfSections == 1 && numberOfRows(inSection: 0) == 0
        }
    }
}
