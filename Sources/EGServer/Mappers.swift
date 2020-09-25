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
    func mapRoot(_ JSONString: String) throws -> (String?, Element) {
        guard let item = Mapper<ObjectResult<Element>>().map(JSONString: JSONString) else {
            throw ServerError(mode: .dataMapping)
        }
        guard item.isSuccess else {
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
    func mapRoot(_ JSONString: String) throws -> (String?, [Element]) {
        guard let item = Mapper<ListResult<Element>>().map(JSONString: JSONString) else {
            throw ServerError(mode: .dataMapping)
        }
        guard item.isSuccess else {
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
    func map(_ JSONString: String) throws -> String {
        guard let item = Mapper<StringResult>().map(JSONString: JSONString) else {
            throw ServerError(mode: .dataMapping)
        }
        guard item.isSuccess else {
            throw ServerError(mode: .server(item.message))
        }
        return item.result
    }
}
