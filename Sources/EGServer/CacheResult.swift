//
//  CacheResult.swift
//  
//
//  Created by youzy01 on 2020/9/11.
//

import Foundation

/// 缓存用到的模型
public struct CacheResult<Element> {
    /// 服务器`Result`jsonString
    public let jsonString: String?
    /// `Result`解析后的模型
    public let result: Element

    public init(jsonString: String?, result: Element) {
        self.jsonString = jsonString
        self.result = result
    }
}
