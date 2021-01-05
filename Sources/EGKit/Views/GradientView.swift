//
//  GradientView.swift
//  YouPlusApp
//
//  Created by youzy01 on 2019/9/11.
//  Copyright © 2019 youzy. All rights reserved.
//

import UIKit

@IBDesignable
public class GradientView: ShadowView {
    @IBInspectable var startColor: UIColor = UIColor.white
    @IBInspectable var endColor: UIColor = UIColor.white

    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0.5, y: 0)
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0.5, y: 1)

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

private extension GradientView {
    var colors: [CGColor] {
        return [startColor.cgColor, endColor.cgColor]
    }
}

@IBDesignable
public class ThreeGradientView: ShadowView {
    @IBInspectable var startColor: UIColor = UIColor.white
    @IBInspectable var minColor: UIColor = UIColor.white
    @IBInspectable var endColor: UIColor = UIColor.white

    public override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        //使用rgb颜色空间
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        //颜色数组（这里使用三组颜色作为渐变）fc6820

        let compoents: [CGFloat] = colors.map { $0.components }.compactMap { $0 }.reduce([], +)
        //没组颜色所在位置（范围0~1)
        let locations: [CGFloat] = [0, 0.5, 1]
        //生成渐变色（count参数表示渐变个数）
        let gradient = CGGradient(colorSpace: colorSpace, colorComponents: compoents,
                                  locations: locations, count: locations.count)!
        //渐变开始位置
        let start = CGPoint(x: 0, y: rect.height / 2)
        //渐变结束位置
        let end = CGPoint(x: rect.width, y: rect.height / 2)
        //绘制渐变
        context.drawLinearGradient(gradient, start: start, end: end,
                                   options: .drawsBeforeStartLocation)
    }
}

private extension ThreeGradientView {
    var colors: [CGColor] {
        return [startColor.cgColor, minColor.cgColor, endColor.cgColor]
    }
}

@IBDesignable
public class GradientOtherView: ShadowView {
    @IBInspectable var startColor: UIColor = UIColor.white
    @IBInspectable var endColor: UIColor = UIColor.white

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
        let start = CGPoint(x: rect.width/2, y: 0)
        //渐变结束位置
        let end = CGPoint(x: rect.width/2, y: rect.height)
        //绘制渐变
        context.drawLinearGradient(gradient, start: start, end: end,
                                   options: .drawsBeforeStartLocation)
    }
}

private extension GradientOtherView {
    var colors: [CGColor] {
        return [startColor.cgColor, endColor.cgColor]
    }
}
