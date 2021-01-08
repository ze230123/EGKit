//
//  ShadowView.swift
//  YouPlusApp
//
//  Created by youzy01 on 2019/9/5.
//  Copyright © 2019 youzy. All rights reserved.
//

import UIKit

/// 阴影view
@IBDesignable
public class ShadowView: CornerView {
    /// 阴影颜色
    @IBInspectable var shadowColor: UIColor? {
        didSet {
            layer.shadowColor = shadowColor?.cgColor
        }
    }

    /// 阴影偏移
    @IBInspectable var shadowOffet: CGSize = .zero {
        didSet {
            layer.shadowOffset = shadowOffet
        }
    }

    /// 阴影透明度 默认 0
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }

    /// 模糊半径
    @IBInspectable var shadowRadius: CGFloat = 3.0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
}

