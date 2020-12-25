//
//  CornerView.swift
//  
//
//  Created by dev-02 on 2020/12/25.
//

import UIKit

/// 圆角View
@IBDesignable
class CornerView: UIView {
    @IBInspectable var isRadius: Bool = false

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var masksToBounds: Bool = false {
        didSet {
            layer.masksToBounds = masksToBounds
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if isRadius {
            layer.cornerRadius = frame.height / 2
        }
    }
}
