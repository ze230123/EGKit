//
//  RF.swift
//  
//
//  Created by youzy01 on 2020/9/17.
//

import UIKit

public enum RefreshAction {
    case load
    case more
}

public struct RF {
    let view: UIScrollView

    public init(view: UIScrollView) {
        self.view = view
    }
}

extension RF {
    public var header: RefreshHeader? {
        nonmutating set {
            if let header = newValue {
                view.addSubview(header)
            }
            view.header = newValue
        }
        get {
            return view.header
        }
    }

    public var footer: RefreshFooter? {
        nonmutating set {
            if let footer = newValue {
                view.addSubview(footer)
            }
            view.footer = newValue
        }
        get {
            return view.footer
        }
    }
}

public extension RF {
    /// 开始刷新(只是header会开始刷新)
    func beginRefresh() {
        header?.beginRefresh()
    }

    func endRefresh(action: RefreshAction, isNotData: Bool) {
        switch action {
        case .load:
            header?.endRefresh()
            footer?.resetRefresh()
            footer?.isHidden = isNotData
        case .more:
            if isNotData {
                footer?.endRefreshForNoMoreData()
            } else {
                footer?.endRefresh()
            }
        }
    }

    func endRefresh(action: RefreshAction, error: Error) {
        switch action {
        case .load:
            header?.endRefresh(error: error)
        case .more:
            footer?.endRefresh(error: error)
        }
    }
}
