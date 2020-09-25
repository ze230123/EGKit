//
//  BaseResult.swift
//
//  服务器返回JSON的模型:ObjectResult、ListResult、StringResult
//  
//
//  Created by youzy01 on 2020/9/17.
//

import Foundation
import ObjectMapper

private extension Map {
    func toJSONString() -> String? {
        guard let dict = currentValue, JSONSerialization.isValidJSONObject(dict) else {
            return nil
        }
        if let data = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}

struct ObjectResult<Element>: Mappable where Element: Mappable {
    var message: String = ""
    var result: Element?
    var code: String = ""
    var isSuccess: Bool = false
    /// 需要保存的`result`jsonString
    var resultValue: String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        message     <- map["message"]
        result      <- map["result"]
        code        <- map["code"]
        isSuccess   <- map["isSuccess"]

        resultValue = map["result"].toJSONString()
    }
}

struct ListResult<Element>: Mappable where Element: Mappable {
    var message: String = ""
    var result: [Element] = []
    var code: String = ""
    var isSuccess: Bool = false

    /// 需要保存的`result`jsonString
    var resultValue: String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        message     <- map["message"]
        result      <- map["result"]
        code        <- map["code"]
        isSuccess   <- map["isSuccess"]

        resultValue = map["result"].toJSONString()
    }
}

struct StringResult: Mappable {
    var message: String = ""
    var result: String = ""
    var code: String = ""
    var isSuccess: Bool = false

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        message     <- map["message"]
        result      <- map["result"]
        code        <- map["code"]
        isSuccess   <- map["isSuccess"]
    }
}
