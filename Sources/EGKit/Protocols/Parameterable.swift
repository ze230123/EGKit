//
//  Parameterable.swift
//  
//
//  Created by dev-02 on 2020/12/28.
//

import Foundation

/// 网络接口参数协议
public protocol Parameterable {
    var parameters: [String: Any] { get }
}
