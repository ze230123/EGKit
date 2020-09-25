//
//  BaseViewController.swift
//  
//
//  Created by youzy01 on 2020/9/17.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController, ErrorHandlerObserverType {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    /// 网络请求、子类重写
    func request() {
    }

    func onReTry() {
        request()
    }
}
