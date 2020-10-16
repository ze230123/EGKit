//
//  LoadAnimateable.swift
//  
//
//  Created by youzy01 on 2020/9/25.
//

import UIKit

/// 加载动画视图协议
public protocol LoadAnimateable where Self: UIView {
    var isLoading: Bool { get set }
    func start()
    func stop()
}
