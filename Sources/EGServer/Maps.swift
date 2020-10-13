//
//  Maps.swift
//  
//
//  Created by youzy01 on 2020/9/17.
//

import Foundation
import ObjectMapper

/// 对象转换工具
///
/// `result`为字典时使用此方法
public struct ObjectMap<Element>: MapHandler where Element: Mappable {
    public init() {}

    public func mapHttpObject() -> (String) throws -> CacheResult<Element> {
        return { value in
            let (jsonString, result) = try ObjectMapper<Element>().mapRoot(value)
            return CacheResult<Element>(jsonString: jsonString, result: result)
        }
    }

    public func mapCacheObject(_ value: String) throws -> CacheResult<Element> {
        let result = try ObjectMapper<Element>().mapResult(value)
        return CacheResult<Element>(jsonString: value, result: result)
    }

    public func mapResultString(_ value: CacheResult<Element>) -> String? {
        return value.jsonString
    }
}

/// 数组转换工具
///
/// `result`为数组时使用此方法
public struct ListMap<ListElement>: MapHandler where ListElement: Mappable {
    public typealias Element = [ListElement]

    public init() {}

    public func mapHttpObject() -> (String) throws -> CacheResult<Element> {
        return { value in
            let (jsonString, result) = try ListMapper<ListElement>().mapRoot(value)
            return CacheResult<Element>(jsonString: jsonString, result: result)
        }
    }

    public func mapCacheObject(_ value: String) throws -> CacheResult<Element> {
        let result = try ListMapper<ListElement>().mapList(value)
        return CacheResult<Element>(jsonString: value, result: result)
    }

    public func mapResultString(_ value: CacheResult<Element>) -> String? {
        return value.jsonString
    }
}

/// String转换工具
///
/// `result`为String或没有`result`字段时使用此方法
public struct StringMap: MapHandler {
    public typealias Element = String

    public init() {}

    public func mapHttpObject() -> (String) throws -> CacheResult<String> {
        return { value in
            let result = try StringMapper().map(value)
            return CacheResult(jsonString: result, result: result)
        }
    }

    public func mapCacheObject(_ value: String) throws -> CacheResult<String> {
        return CacheResult(jsonString: value, result: value)
    }

    public func mapResultString(_ value: CacheResult<Element>) -> String? {
        return value.jsonString
    }
}
