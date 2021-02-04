//
//  ServerError.swift
//  
//
//  Created by youzy01 on 2020/9/11.
//

import Foundation
import Moya
import Alamofire

/// 网络服务异常
public struct ServerError: Error {
    var message: String
    public var mode: Mode

    public var code: Int {
        return mode.code
    }
    public init(mode: Mode) {
        message = mode.title
        self.mode = mode
    }
}

extension ServerError: LocalizedError {
    public var errorDescription: String? {
        return mode.title
    }
}

extension ServerError {
    struct Code {
        /// http其他错误
        static let httpOther = 23001
        /// 未找到缓存
        static let noCache = 23002
        /// 请求过于频繁
        static let overload = 23003
        /// 没有网络
        static let noNetwork = 23004
        /// 您没有权限查看该数据
        static let noAuthority = 23005
        /// 连接超时
        static let timeout = 23006
        /// 无法连接主机地址
        static let unknownHost = 23007
        /// 数据转换失败
        static let dataMapping = 23008
        /// 模型转换失败
        static let modelMapping = 23009
        /// 服务器返回错误信息
        static let server = 230010
        /// 未知错误
        static let unknown = 230011
    }
}

public extension ServerError {
    enum Mode {
        /// http其他错误
        case httpOther
        /// 未找到缓存
        case noCache
        /// 请求过于频繁
        case overload
        /// 没有网络
        case noNetwork
        /// 您没有权限查看该数据
        case noAuthority
        /// 连接超时
        case timeout
        /// 无法连接主机地址
        case unknownHost
        /// 数据转换失败
        case dataMapping
        /// 模型转换失败
        case modelMapping
        /// 服务器返回错误信息
        case server(String)
        /// 未知错误
        case unknown(String)

        var detail: (title: String, content: String) {
            switch self {
            case .httpOther:        return ("HTTP其他错误", "")
            case .noCache:          return ("未找到缓存", "请连接网络后重试")
            case .overload:         return ("请求过于频繁", "请稍后再试")
            case .noNetwork:        return ("没有找到网络", "请检查网络后重试")
            case .noAuthority:      return ("您没有权限查看该数据", "")
            case .timeout:          return ("连接超时", "请检查网络后重试")
            case .unknownHost:      return ("无法连接主机地址", "")
            case .dataMapping:      return ("数据解析出错", "")
            case .modelMapping:     return ("数据模型转换失败", "")
            case .server(let msg):  return (msg, "出错啦")
            case .unknown(let msg): return (msg, "出错啦")
            }
        }

        public var title: String {
            return detail.title
        }

        public var content: String {
            return detail.content
        }

        public var code: Int {
            switch self {
            case .httpOther:        return Code.httpOther
            case .noCache:          return Code.noCache
            case .overload:         return Code.overload
            case .noNetwork:        return Code.noNetwork
            case .noAuthority:      return Code.noAuthority
            case .timeout:          return Code.timeout
            case .unknownHost:      return Code.unknownHost
            case .dataMapping:      return Code.dataMapping
            case .modelMapping:     return Code.modelMapping
            case .server:           return Code.server
            case .unknown:          return Code.unknown
            }
        }
    }
}

/// 接口异常处理
class ApiException {
    static func handleException(_ error: Error) -> ServerError {
        return error.asAPIError()
    }
}

fileprivate extension Error {
    func asAPIError() -> ServerError {
        do {
            return try handler()
        } catch URLError.timedOut {
            return ServerError(mode: .timeout)
        } catch URLError.notConnectedToInternet {
            return ServerError(mode: .noNetwork)
        } catch {
            return ServerError(mode: .unknown(error.localizedDescription))
        }
    }

    func handler() throws -> ServerError {
        if let error = self as? ServerError {
            return error
        }
        guard let moyaError = self as? MoyaError else {
            return ServerError(mode: .unknown(localizedDescription))
        }

        switch moyaError {
        case .statusCode(let response):
            switch response.statusCode {
            case 408:
                return ServerError(mode: .timeout)
            case 401:
                return ServerError(mode: .noAuthority)
            case 403:
                return ServerError(mode: .unknown(""))
            case 900:
                return ServerError(mode: .unknown(""))
            default:
                let msg = HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
                return ServerError(mode: .unknown(msg))
            }
        case .stringMapping, .jsonMapping, .imageMapping, .objectMapping:
            return ServerError(mode: .dataMapping)
        case let .underlying(error as AFError, _):
            if let unerror = error.underlyingError {
                throw unerror
            }
            return ServerError(mode: .unknown(error.localizedDescription))
        default:
            return ServerError(mode: .unknown(moyaError.localizedDescription))
        }
    }
}
