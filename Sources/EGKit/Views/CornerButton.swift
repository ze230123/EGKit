//
//  GradientButton.swift
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

@IBDesignable
class BorderButton: CornerButton {
    @IBInspectable var borderColor: UIColor? = UIColor.white {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
}

@IBDesignable
class ShadowButton: CornerButton {
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

@IBDesignable
class GradientButton: ShadowButton {
    @IBInspectable var startColor: UIColor = .cFF5053
    @IBInspectable var endColor: UIColor = .cE9302D

    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0, y: 0.5)
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 1, y: 1.5)

    @IBInspectable var disabledStartColor: UIColor = .cFBAAAA
    @IBInspectable var disabledEndColor: UIColor = .cF29C9A

    override var isEnabled: Bool {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        //使用rgb颜色空间
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        //颜色数组（这里使用三组颜色作为渐变）fc6820

        let compoents: [CGFloat] = colors.map { $0.components }.compactMap { $0 }.reduce([], +)
        //没组颜色所在位置（范围0~1)
        let locations: [CGFloat] = [0, 1]
        //生成渐变色（count参数表示渐变个数）
        let gradient = CGGradient(colorSpace: colorSpace, colorComponents: compoents,
                                  locations: locations, count: locations.count)!
        //渐变开始位置
        let start = CGPoint(x: rect.width * startPoint.x, y: rect.height * startPoint.y)
        //渐变结束位置
        let end = CGPoint(x: rect.width * endPoint.x, y: rect.height * endPoint.y)

        //绘制渐变
        context.drawLinearGradient(gradient, start: start, end: end,
                                   options: .drawsBeforeStartLocation)
    }
}

extension GradientButton {
    var colors: [CGColor] {
        if state == .disabled {
            return [disabledStartColor.cgColor, disabledEndColor.cgColor]
        } else {
            return [startColor.cgColor, endColor.cgColor]
        }
    }
}
