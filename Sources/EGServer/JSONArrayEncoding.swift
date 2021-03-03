//
//  JSONArrayEncoding.swift
//  
//
//  Created by dev-02 on 2021/3/3.
//

import Alamofire
import Foundation

public struct JSONArrayEncoding: ParameterEncoding {
    public static let `default` = JSONArrayEncoding()

    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()

        guard let json = parameters?["jsonArray"] else {
            return request
        }

        let data = try JSONSerialization.data(withJSONObject: json, options: [])

        if request.value(forHTTPHeaderField: "Content-Type") == nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        request.httpBody = data

        return request
    }
}

