//
//  CellReusable.swift
//  
//
//  Created by youzy01 on 2020/9/28.
//

import UIKit

/// Cell快速注册，获取协议
public protocol CellReusable: class {
    /// 复用ID
    static var reuseableIdentifier: String {get}
    static var nib: UINib? {get}
}

public extension CellReusable where Self: UITableViewCell {
    static var reuseableIdentifier: String {
        return String(describing: self)
    }

    static var nib: UINib? {
        return nil
    }
}

public extension CellReusable where Self: UITableViewHeaderFooterView {
    static var reuseableIdentifier: String {
        return String(describing: self)
    }

    static var nib: UINib? {
        return nil
    }
}

public extension CellReusable where Self: UICollectionViewCell {
    static var reuseableIdentifier: String {
        return String(describing: self)
    }

    static var nib: UINib? {
        return nil
    }
}

public extension CellReusable where Self: UICollectionReusableView {
    static var reuseableIdentifier: String {
        return String(describing: self)
    }

    static var nib: UINib? {
        return nil
    }
}

/// Cell配置数据协议
public protocol CellConfigurable: CellReusable {
    associatedtype T
    func configure(_ item: T)
}
