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

/// Int/String 转为 String
let ToStringTransform = TransformOf<String, Any>(fromJSON: { (value: Any?) -> String? in
    // 把值从 String? 转成 Int?
    if let newValue = value as? String {
        return newValue
    }
    if let newValue = value as? Int {
        return "\(newValue)"
    }
    return nil
}, toJSON: { (value: String?) -> Any? in
    return value
})

protocol Successable {
    var isSuccessCode: Bool { get }
    var isSuccess: Bool { get set }
}

struct ObjectResult<Element>: Mappable, Successable where Element: Mappable {    
    var message: String = ""
    var result: Element?
    var code: String = ""
    var isSuccess: Bool = false
    /// 需要保存的`result`jsonString
    var resultValue: String?

    /// 使用code判断请求是否成功
    var isSuccessCode: Bool {
        return code == "1"
    }

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        message     <- map["message"]
        result      <- map["result"]
        code        <- (map["code"], ToStringTransform)
        isSuccess   <- map["isSuccess"]

        resultValue = map["result"].toJSONString()
    }
}

struct ListResult<Element>: Mappable, Successable where Element: Mappable {
    var message: String = ""
    var result: [Element] = []
    var code: String = ""
    var isSuccess: Bool = false

    /// 需要保存的`result`jsonString
    var resultValue: String?

    /// 使用code判断请求是否成功
    var isSuccessCode: Bool {
        return code == "1"
    }

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        message     <- map["message"]
        result      <- map["result"]
        code        <- (map["code"], ToStringTransform)
        isSuccess   <- map["isSuccess"]

        resultValue = map["result"].toJSONString()
    }
}

struct ListStringResult: Mappable, Successable {
    var message: String = ""
    var result: [String] = []
    var code: String = ""
    var isSuccess: Bool = false

    /// 需要保存的`result`jsonString
    var resultValue: String?

    /// 使用code判断请求是否成功
    var isSuccessCode: Bool {
        return code == "1"
    }

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        message     <- map["message"]
        result      <- map["result"]
        code        <- map["code"]
        isSuccess   <- map["isSuccess"]

        resultValue = map["result"].toJSONString()
    }
}


struct StringResult: Mappable, Successable {
    var message: String = ""
    var result: String = ""
    var code: String = ""
    var isSuccess: Bool = false

    /// 使用code判断请求是否成功
    var isSuccessCode: Bool {
        return code == "1"
    }

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        message     <- map["message"]
        result      <- map["result"]
        code        <- map["code"]
        isSuccess   <- map["isSuccess"]
    }
}
