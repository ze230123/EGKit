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

    /// 设置缓存
    /// - Parameters:
    ///   - cache: 缓存内容
    ///   - key: 缓存key
    ///   - expiry: 过期时间, nil == 永久
    public func setCache(_ cache: String, key: String, expiry: Expiry? = nil) {
        store.setObject(cache, forKey: key.md5, expiry: expiry)
    }

    /// 获取缓存
    /// - Parameter key: 缓存key
    /// - Returns: 缓存内容
    public func cache(for key: String) -> String? {
        return store.object(forKey: key.md5)
    }

    /// 删除指定缓存
    /// - Parameter forKey: 缓存key
    public func remove(forKey: String) {
        return store.removeObject(forKey: forKey.md5)
    }

    public var totalSize: UInt64 {
        return store.totalSize()
    }

    public func removeAll() {
        store.removeAll()
    }
}
