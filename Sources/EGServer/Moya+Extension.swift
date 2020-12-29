//
//  Moya+Extension.swift
//  
//
//  Created by youzy01 on 2020/9/14.
//

import Moya

public typealias Parameters = [String: Any]

public protocol MoyaAddable {
    var policy: CachePolicy { get }
}

public extension Task {
    var parameters: Parameters {
        switch self {
        case let .requestParameters(parameters, _):
            return parameters
        default:
            return [:]
        }
    }
}
