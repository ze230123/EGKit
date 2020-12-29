//
//  ShadowButton.swift
//  
//
//  Created by youzy01 on 2020/12/28.
//

import UIKit

/// 阴影按钮
@IBDesignable
public class ShadowButton: CornerButton {
    /// 阴影颜色
    @IBInspectable public var shadowColor: UIColor? {
        didSet {
            layer.shadowColor = shadowColor?.cgColor
        }
    }

    /// 阴影偏移
    @IBInspectable public var shadowOffet: CGSize = .zero {
        didSet {
            layer.shadowOffset = shadowOffet
        }
    }

    /// 阴影透明度 默认 0
    @IBInspectable public var shadowOpacity: Float = 0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }

    /// 模糊半径
    @IBInspectable public var shadowRadius: CGFloat = 3.0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
}

