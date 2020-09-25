//
//  ViewErrorable.swift
//  
//
//  Created by youzy01 on 2020/9/25.
//

import UIKit
import EGServer

/// 错误提示视图协议
public protocol ViewErrorable where Self: UIView {
    func update(_ error: ServerError, observer: ErrorHandlerObserverType?)
}
