//
//  MapHandler.swift
//  
//
//  Created by youzy01 on 2020/9/11.
//

import Foundation

/// 数据转换处理协议
public protocol MapHandler {
    /// 数据类型
    associatedtype Element

    /// 服务器json转模型
    func mapHttpObject() -> (String) throws -> CacheResult<Element>
    /// 本地缓存json转模型
    func mapCacheObject(_ value: String) throws -> CacheResult<Element>
    /// 模型转排序后的字符串
    ///
    /// 用于本地数据和网络数据比对
    func mapResultString(_ value: CacheResult<Element>) -> String?
}
