//
//  CornerButton.swift
//  YouPlusApp
//
//  Created by youzy01 on 2019/9/5.
//  Copyright © 2019 youzy. All rights reserved.
//

import UIKit

@IBDesignable
class CornerButton: UIButton {
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

    @IBInspectable var numberOfLines: Int = 0 {
        didSet {
            titleLabel?.numberOfLines = numberOfLines
        }
    }
}
