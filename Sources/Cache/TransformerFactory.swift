//
//  File.swift
//  
//
//  Created by youzy01 on 2020/9/11.
//

import Foundation

/// 转换工厂类
public class TransformerFactory {
    // FIXME: `encode` `decode`
    public static func forString() -> Transformer<String> {
        let toData: (String?) -> Data? = { $0?.data(using: .utf8) }

        let fromData: (Data?) -> String? = { guard let data = $0 else { return nil}; return String(data: data, encoding: .utf8) }

        return Transformer<String>(toData: toData, fromData: fromData)
    }
}
