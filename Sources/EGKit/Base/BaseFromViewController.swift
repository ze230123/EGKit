//
//  BaseFromViewController.swift
//  
//
//  Created by youzy01 on 2021/1/7.
//

import UIKit
import Eureka
import RxSwift

open class BaseFromViewController: FormViewController, ErrorHandlerObserverType {
    public let disposeBag = DisposeBag()

    deinit {
        debugPrint("\(type(of: self))_deinit")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = UIColor.darkGray
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    /// 网络请求、子类重写
    open func request() {
    }

    public func onReTry() {
        request()
    }

    @IBAction open func backAction() {
        navigationController?.popViewController(animated: true)
    }
}
