//
//  ObserverHandler.swift
//  
//
//  Created by youzy01 on 2020/9/17.
//

import UIKit

/// RxSwift 观察者处理协议
///
/// 将闭包转为方法
protocol ObserverHandler where Self: UIViewController {
    associatedtype Element
    func resultHandler(_ result: Swift.Result<Element, ServerError>)

    func onSuccess(_ item: Element)
    func onFailure(_ error: ServerError)
}
