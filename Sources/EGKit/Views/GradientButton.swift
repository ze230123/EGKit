//
//  GradientButton.swift
//  
//
//  Created by youzy01 on 2020/12/28.
//

import UIKit

/// 渐变按钮
@IBDesignable
public class GradientButton: ShadowButton {
    @IBInspectable public var startColor: UIColor = UIColor(hex: 0xFF5053)
    @IBInspectable public var endColor: UIColor = UIColor(hex: 0xE9302D)

    @IBInspectable public var startPoint: CGPoint = CGPoint(x: 0, y: 0.5)
    @IBInspectable public var endPoint: CGPoint = CGPoint(x: 1, y: 1.5)

    @IBInspectable public var disabledStartColor: UIColor = UIColor(hex: 0xFBAAAA)
    @IBInspectable public var disabledEndColor: UIColor = UIColor(hex: 0xF29C9A)

    public override var isEnabled: Bool {
        didSet {
            setNeedsDisplay()
        }
    }

    public override func draw(_ rect: CGRect) {
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
