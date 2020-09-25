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
    let jsonString: String?
    /// `Result`解析后的模型
    let result: Element

    init(jsonString: String?, result: Element) {
        self.jsonString = jsonString
        self.result = result
    }
}
