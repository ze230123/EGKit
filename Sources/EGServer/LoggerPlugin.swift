//
//  LoggerPlugin.swift
//  
//
//  Created by youzy01 on 2020/12/29.
//

import Foundation
import Moya

public final class LoggerPlugin: PluginType {
    public init() {}

    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        var items: [String] = []
        items.append("************************** 网络请求完成 start **************************\n")

        switch result {
        case .success(let response):
            items.append("请求地址: \(response.request?.url?.absoluteString ?? "无") \n")
            items.append("请求类型: \(response.request?.httpMethod ?? "无") \n")
            items.append("响应代码: \(response.statusCode) \n")
            items.append("请求头部: \(response.request?.allHTTPHeaderFields?.description ?? "空") \n")
            items.append("请求参数: \(response.request?.httpBody?.jsonString ?? "无") \n")
            items.append("返回数据: \((try? response.mapString()) ?? "无") \n")
        case .failure(let error):
            items.append("请求地址: \(error.response?.request?.url?.absoluteString ?? "无") \n")
            items.append("请求类型: \(error.response?.request?.httpMethod ?? "无") \n")
            items.append("响应代码: \(error.response?.statusCode ?? 0) \n")
            items.append("请求头部: \(error.response?.request?.allHTTPHeaderFields?.description ?? "空") \n")
            items.append("请求参数: \(error.response?.request?.httpBody?.jsonString ?? "无") \n")
            items.append("错误信息: \(error.localizedDescription) \n")
        }
        items.append("************************** 网络请求完成 end **************************\n")

        debugPrint(items)
    }
}

private extension Data {
    var jsonString: String {
        guard let value = try? JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String: Any] else {
            return ""
        }
        return value.description
    }
}
