//
//  File.swift
//  
//
//  Created by youzy01 on 2020/10/29.
//

import RxSwift

public extension Observable {
    /// 自定义订阅，用于使用闭包回调的方法
    /// - Parameters:
    ///   - onSuccess: 成功闭包
    ///   - onFailure: 失败闭包
    /// - Returns: 用于取消订阅可观察序列的订阅对象。
    func subscribe(onSuccess: ((Element) -> Void)?, onFailure: ((ServerError) -> Void)? = nil) -> RxSwift.Disposable  {
        return observeOn(MainScheduler.asyncInstance).subscribe(onNext: onSuccess, onError: { onFailure?(ApiException.handleException($0)) })
    }

    /// 自定义订阅(不需要`Element`)，用于使用闭包回调的方法
    /// - Parameters:
    ///   - onSuccess: 成功闭包
    ///   - onFailure: 失败闭包
    /// - Returns: 用于取消订阅可观察序列的订阅对象。
    func subscribe(onSuccess: (() -> Void)?, onFailure: ((ServerError) -> Void)? = nil) -> RxSwift.Disposable  {
        return observeOn(MainScheduler.asyncInstance).subscribe(onNext: { _ in onSuccess?()}, onError: { onFailure?(ApiException.handleException($0)) })
    }
}


