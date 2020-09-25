//
//  UIScrollView+Extension.swift
//  
//
//  Created by youzy01 on 2020/9/17.
//

import UIKit

public extension UIScrollView {
    var rf: RF {
        return RF(view: self)
    }
}

private var kEGRefreshHeaderKey: String = "header"
private var kEGRefreshFooterKey: String = "footer"

extension UIScrollView {
    var header: RefreshHeader? {
        set {
            objc_setAssociatedObject(self, &kEGRefreshHeaderKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            objc_getAssociatedObject(self, &kEGRefreshHeaderKey) as? RefreshHeader
        }
    }

    var footer: RefreshFooter? {
        set {
            objc_setAssociatedObject(self, &kEGRefreshFooterKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            objc_getAssociatedObject(self, &kEGRefreshFooterKey) as? RefreshFooter
        }
    }

    var inset: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return adjustedContentInset
        } else {
            return contentInset
        }
    }
}
