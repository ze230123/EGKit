//
//  RefreshState.swift
//  SwiftPackageDemo
//
//  Created by youzy01 on 2020/9/22.
//  Copyright © 2020 优志愿. All rights reserved.
//

import Foundation

enum RefreshState {
    /// 闲置状态
    case none
    /// 拖拽中
    case pulling
    /// 松开就可以进行刷新的状态
    case ready
    /// 将要刷新
    case willRefresh
    /// 正在刷新中
    case refreshing
    /// 结束刷新（只是结束，控件还在显示）
    case finish
    /// 没有更多数据
    case noMoreData
}
