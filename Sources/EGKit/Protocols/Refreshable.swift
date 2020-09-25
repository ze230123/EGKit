//
//  Refreshable.swift
//  
//
//  Created by youzy01 on 2020/9/17.
//

import UIKit

public protocol Refreshable: class {
    var pageIndex: Int { get set }
    func loadData()
    func moreData()
}

public extension Refreshable where Self: BaseTableViewController {
    func addRefreshHeader() {
        tableView.addRefreshHeader { [weak self] in
            self?.loadData()
        }
    }

    func addRefreshFooter() {
        tableView.addRefreshFooter { [weak self] in
            self?.moreData()
        }
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
        collectionView.addRefreshHeader { [weak self] in
            self?.loadData()
        }
    }

    func addRefreshFooter() {
        collectionView.addRefreshFooter { [weak self] in
            self?.moreData()
        }
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
