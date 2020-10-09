//
//  Refreshable.swift
//  
//
//  Created by youzy01 on 2020/9/17.
//

import UIKit
import EGRefresh

public protocol Refreshable: class {
    var pageIndex: Int { get set }
    func loadData()
    func moreData()
}

public extension Refreshable where Self: BaseTableViewController {
    func addRefreshHeader() {
        let header = RefreshNormalHeader { [weak self] in
            self?.loadData()
        }
        tableView.rf.header = header
    }

    func addRefreshFooter() {
        let footer = RefreshNormalFooter { [weak self] in
            self?.moreData()
        }
        footer.retryBlock = { [weak self] in
            self?.onReTry()
        }
        footer.isHidden = true
        tableView.rf.footer = footer
    }

    func loadData() {
        pageIndex = 1
        willRequest(action: .load)
    }

    func moreData() {
        pageIndex += 1
        willRequest(action: .more)
    }
}

public extension Refreshable where Self: BaseCollectionViewController {
    func addRefreshHeader() {
        let header = RefreshNormalHeader { [weak self] in
            self?.loadData()
        }
        collectionView.rf.header = header
    }

    func addRefreshFooter() {
        let footer = RefreshNormalFooter { [weak self] in
            self?.moreData()
        }
        footer.isHidden = true
        collectionView.rf.footer = footer
    }

    func loadData() {
        pageIndex = 1
        willRequest(action: .load)
    }

    func moreData() {
        pageIndex += 1
        willRequest(action: .more)
    }
}
