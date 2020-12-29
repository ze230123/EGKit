//
//  CornerButton.swift
// 
//
//  Created by dev-02 on 2020/12/25.
//
//

import UIKit

/// 圆角Button
@IBDesignable
public class CornerButton: UIButton {
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable public var masksToBounds: Bool = false {
        didSet {
            layer.masksToBounds = masksToBounds
        }
    }

    @IBInspectable public var numberOfLines: Int = 0 {
        didSet {
            titleLabel?.numberOfLines = numberOfLines
        }
    }
}
