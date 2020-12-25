//
//  UIViewController+Transitions.swift
//
//
// Created by dev-02 on 2020/12/25.
// 

import UIKit
import RTRootNavigationController

extension UIViewController {
    func push(_ vc: UIViewController, animated: Bool = true) {
        if navigationController?.viewControllers.count == 1 {
            vc.hidesBottomBarWhenPushed = true
        } else {
            vc.hidesBottomBarWhenPushed = false
        }
        navigationController?.pushViewController(vc, animated: animated)
    }

    func present(_ vc: UIViewController, animated: Bool = true) {
//        DispatchQueue.main.async {
            self.present(vc, animated: animated, completion: nil)
//        }
    }

    func popViewController(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }

    func popToRootViewController(animated: Bool = true) {
        navigationController?.popToRootViewController(animated: animated)
    }

    func popToViewController(vc: UIViewController, animated: Bool = true) {
        navigationController?.popToViewController(vc, animated: true)
    }
}

extension UIViewController {
    var appdelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    /// 添加通知观察者
    func addObserver(with selector: Selector, name: NotificationName, object: Any? = nil) {
        NotificationCenter.default.addObserver(self, selector: selector, name: NSNotification.Name(rawValue: name.rawValue), object: object)
    }
    /// 发送通知
    func postNotification(name: NotificationName, object: Any?) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: name.rawValue), object: object)
    }

    /// 添加通知观察者
    func addObserver(name: NSNotification.Name, selector: Selector, object: Any? = nil) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: object)
    }
}
