//
//  Cache.swift
//
//
//  Created by youzy01 on 2020/9/11.
//

import Foundation

/// 缓存类
final public class Cache {
     public static let shared = Cache()

    private let store = DiskStorage<String>(
        config: DiskConfig(
            name: "URLCache",
            maxSize: 1024 * 10,
            expiry: .never),
        transformer: TransformerFactory.forString()
    )

    init() {
//        print(store.path)
    }

    public func setCache(_ cache: String, key: String, expiry: Expiry? = nil) {
        store.setObject(cache, forKey: key.md5, expiry: expiry)
    }

    public func cache(for key: String) -> String? {
        return store.object(forKey: key.md5)
    }

    public var totalSize: UInt64 {
        return store.totalSize()
    }

    public func removeAll() {
        store.removeAll()
    }
}
