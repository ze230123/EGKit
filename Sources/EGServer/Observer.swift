//
//  Observer.swift
//  
//
//  Created by youzy01 on 2020/9/17.
//

import Foundation
import RxSwift
import ObjectMapper

/// 任意对象观察者
public class Observer<Element>: ObserverType {
    public typealias EventHandler = (Result<Element, ServerError>) -> Void

    let observer: EventHandler

    deinit {
        debugPrint("\(self)_deinit")
    }

    public init<Observer>(observer: Observer) where Element == Observer.Element, Observer: ObserverHandler {
        self.observer = { [weak observer] result in
            switch result {
            case .success(let element):
                observer?.onSuccess(element)
            case .failure(let error):
                observer?.onFailure(error)
            }
        }
    }

    public init(observer: @escaping EventHandler) {
        self.observer = observer
    }

//    public init(onSuccess: @escaping (Element) -> Void, onFailure: @escaping (ServerError) -> Void) {
//        observer = { result in
//            switch result {
//            case .success(let element):
//                onSuccess(element)
//            case .failure(let error):
//                onFailure(error)
//            }
//        }
//    }

    public func on(_ event: Event<Element>) {
        DispatchQueue.main.async { [weak self] in
            switch event {
            case .next(let item):
                self?.observer(.success(item))
            case .error(let error):
                self?.observer(.failure(ApiException.handleException(error)))
            case .completed: break
            }
        }
    }
}

/// 遵守`Mappable`协议观察者
public class ObjectObserver<Element>: Observer<Element> where Element: Mappable {
    public private(set) var map: ObjectMap<Element>!

    public init<Observer>(key: SuccessKey = .isSuccess, observer: Observer) where Element == Observer.Element, Observer: ObserverHandler {
        map =  ObjectMap<Element>(key: key)
        super.init(observer: observer)
    }
}

/// 任意对象列表观察者
///
/// `ListElement`没有限定类型，如果有自定义类型和继承此类，自行实现mapObject()wwwwwwwwwwww/// `Mappable`类型的数据模型请使用`ObjectListObserver`
public class ListObserver<ListElement>: ObserverType {
    public typealias Element = [ListElement]

    public typealias EventHandler = (Result<Element, ServerError>) -> Void

    let observer: EventHandler

    deinit {
        print("\(self)_deinit")
    }

    public init<Observer>(observer: Observer) where Element == Observer.Element, Observer: ObserverHandler {
        self.observer = { [weak observer] result in
            switch result {
            case .success(let element):
                observer?.onSuccess(element)
            case .failure(let error):
                observer?.onFailure(error)
            }
        }
    }

    public init(observer: @escaping EventHandler) {
        self.observer = observer
    }

//    public init(onSuccess: @escaping (Element) -> Void, onFailure: @escaping (ServerError) -> Void) {
//        observer = { result in
//            switch result {
//            case .success(let element):
//                onSuccess(element)
//            case .failure(let error):
//                onFailure(error)
//            }
//        }
//    }

    public func on(_ event: Event<[ListElement]>) {
        DispatchQueue.main.async { [weak self] in
            switch event {
            case .next(let item):
                self?.observer(.success(item))
            case .error(let error):
                self?.observer(.failure(ApiException.handleException(error)))
            case .completed: break
            }
        }
    }
}

/// 对象列表观察者
///
/// `ListElement`遵守`Mappable`协议
public class ObjectListObserver<ListElement>: ListObserver<ListElement> where ListElement: Mappable {
//    public let map = ListMap<ListElement>()

    public private(set) var map: ListMap<ListElement>!

    public init<Observer>(key: SuccessKey = .isSuccess, observer: Observer) where Element == Observer.Element, Observer: ObserverHandler {
        map =  ListMap<ListElement>(key: key)
        super.init(observer: observer)
    }
}

/// 返回String或`Result`没有返回的观察者
public class VoidObserver: Observer<String> {
    public let map = StringMap()

//    public init(onSuccess: @escaping () -> Void, onFailure: @escaping (ServerError) -> Void) {
//        super.init(onSuccess: { _ in onSuccess() }, onFailure: onFailure)
//    }
}
