//
//  BaseViewController.swift
//  
//
//  Created by youzy01 on 2020/9/17.
//

import UIKit
import RxSwift

open class BaseViewController: UIViewController, ErrorHandlerObserverType {
    public let disposeBag = DisposeBag()

    deinit {
        debugPrint("\(type(of: self))_deinit")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = UIColor.darkGray
        navigationController?.navigationBar.barTintColor = .white
    }

    /// 网络请求、子类重写
    open func request() {
    }

    public func onReTry() {
        request()
    }

    @IBAction open func backAction() {
//        popViewController()
        navigationController?.popViewController(animated: true)
    }
}
