//
//  Mappers.swift
//
//  服务器JSON转模型映射器：ObjectMapper、ListMapper、StringMapper
//
//  Created by youzy01 on 2020/9/17.
//

import Foundation
import ObjectMapper

/// 数据模型转换处理
struct ObjectMapper<Element> where Element: Mappable {
    /// 将网络JSON转为模型
    /// - Parameters:
    ///   - JSONString: JSON String
    ///   - forKey: 判断请求是否成功的`key`
    /// - Throws: 转换数据发生的错误
    /// - Returns: 元组： `result`节点的JSON String，`result`节点的模型
    func mapRoot(_ JSONString: String, forKey: SuccessKey) throws -> (String?, Element) {
        guard let item = Mapper<ObjectResult<Element>>().map(JSONString: JSONString) else {
            throw ServerError(mode: .dataMapping)
        }

        guard forKey.getIsSuccess(item) else {
            throw ServerError(mode: .server(item.message))
        }
        guard let result = item.result else {
            throw ServerError(mode: .modelMapping)
        }
        return (item.resultValue, result)
    }

    func mapResult(_ JSONString: String) throws -> Element {
        guard let item = Mapper<Element>().map(JSONString: JSONString) else {
            throw ServerError(mode: .dataMapping)
        }
        return item
    }
}

/// 数据模型转换处理
struct ListMapper<Element> where Element: Mappable {
    /// 将网络JSON转为模型
    /// - Parameters:
    ///   - JSONString: JSON String
    ///   - forKey: 判断请求是否成功的`key`
    /// - Throws: 转换数据发生的错误
    /// - Returns: 元组： `result`节点的JSON String，Result节点的模型
    func mapRoot(_ JSONString: String, forKey: SuccessKey) throws -> (String?, [Element]) {
        guard let item = Mapper<ListResult<Element>>().map(JSONString: JSONString) else {
            throw ServerError(mode: .dataMapping)
        }
        guard forKey.getIsSuccess(item) else {
            throw ServerError(mode: .server(item.message))
        }
        return (item.resultValue, item.result)
    }

    func mapList(_ JSONString: String) throws -> [Element] {
        guard let item = Mapper<Element>().mapArray(JSONString: JSONString) else {
            throw ServerError(mode: .dataMapping)
        }
        return item
    }
}

/// 数据模型转换处理
struct StringMapper {
    /// 将网络JSON转为模型
    /// - Parameters:
    ///   - JSONString: JSON String
    ///   - forKey: 判断请求是否成功的`key`
    /// - Throws: 转换数据发生的错误
    /// - Returns: 元组： `result`节点的JSON String，Result节点的模型
    func map(_ JSONString: String, forKey: SuccessKey) throws -> String {
        guard let item = Mapper<StringResult>().map(JSONString: JSONString) else {
            throw ServerError(mode: .dataMapping)
        }
        guard forKey.getIsSuccess(item) else {
            throw ServerError(mode: .server(item.message))
        }
        return item.result
    }
}
