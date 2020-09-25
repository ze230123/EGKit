//
//  File.swift
//  
//
//  Created by youzy01 on 2020/9/17.
//

import Foundation
import RxSwift
import ObjectMapper

/// 任意对象观察者
public class Observer<Element>: ObserverType {
    typealias EventHandler = (Result<Element, ServerError>) -> Void

    public let disposeBag: DisposeBag
    let observer: EventHandler

    deinit {
        print("\(self)_deinit")
    }

    init<Observer>(disposeBag: DisposeBag, observer: Observer) where Element == Observer.Element, Observer: ObserverHandler {
        self.disposeBag = disposeBag
        self.observer = { [weak observer] result in
            observer?.resultHandler(result)
        }
    }

    init(disposeBag: DisposeBag, observer: @escaping EventHandler) {
        self.disposeBag = disposeBag
        self.observer = observer
    }

    public func on(_ event: Event<Element>) {
        switch event {
        case .next(let item):
            observer(.success(item))
        case .error(let error):
            observer(.failure(ApiException.handleException(error)))
        case .completed: break
        }
    }
}

/// 遵守`Mappable`协议观察者
public class ObjectObserver<Element>: Observer<Element> where Element: Mappable {
    public let map = ObjectMap<Element>()
}

/// 任意对象列表观察者
///
/// `ListElement`没有限定类型，如果有自定义类型和继承此类，自行实现mapObject()
/// `Mappable`类型的数据模型请使用`ObjectListObserver`
public class ListObserver<ListElement>: ObserverType {
    public typealias Element = [ListElement]

    typealias EventHandler = (Result<Element, ServerError>) -> Void

    public let disposeBag: DisposeBag
    let observer: EventHandler

    deinit {
        print("\(self)_deinit")
    }

    init<Observer>(disposeBag: DisposeBag, observer: Observer) where Element == Observer.Element, Observer: ObserverHandler {
        self.disposeBag = disposeBag
        self.observer = { [weak observer] result in
            observer?.resultHandler(result)
        }
    }

    init(disposeBag: DisposeBag, observer: @escaping EventHandler) {
        self.disposeBag = disposeBag
        self.observer = observer
    }

    public func on(_ event: Event<[ListElement]>) {
        switch event {
        case .next(let item):
            observer(.success(item))
        case .error(let error):
            observer(.failure(ApiException.handleException(error)))
        case .completed: break
        }
    }
}

/// 对象列表观察者
///
/// `ListElement`遵守`Mappable`协议
public class ObjectListObserver<ListElement>: ListObserver<ListElement> where ListElement: Mappable {
    public let map = ListMap<ListElement>()
}

/// 返回String或`Result`没有返回的观察者
class VoidObserver: Observer<String> {
    public let map = StringMap()
}
