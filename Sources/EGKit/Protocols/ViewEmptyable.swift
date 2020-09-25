//
//  ViewEmptyable.swift
//  
//
//  Created by youzy01 on 2020/9/25.
//

import UIKit

/// 空视图协议
public protocol ViewEmptyable where Self: UIView {
    func updateTitle(_ title: String)
    func updateContent(_ content: String)
}
