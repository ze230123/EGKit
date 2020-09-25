//
//  ErrorHandlerObserverType.swift
//  
//
//  Created by youzy01 on 2020/9/25.
//

import UIKit

/// 错误处理回调
public protocol ErrorHandlerObserverType where Self: BaseViewController {
    /// 重试
    func onReTry()
}
