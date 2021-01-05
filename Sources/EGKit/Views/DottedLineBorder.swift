//
//  DottedLine.swift
//  YouZhiYuan
//
//  Created by 泽i on 2018/9/5.
//  Copyright © 2018年 泽i. All rights reserved.
//

import UIKit
/// 虚线view
@IBDesignable
public class DottedLineView: UIView {

    @IBInspectable var lineColor: UIColor = UIColor(hex: 0xE9E9E9)

    @IBInspectable var line: CGFloat = 2
    @IBInspectable var space: CGFloat = 3

    public override func draw(_ rect: CGRect) {
        // 获取上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        // 画虚线
        /**设置起始和结束位置**/
        var path: CGMutablePath
        if rect.width > rect.height {
            path = hPath(rect)
        } else {
            path = vPath(rect)
        }
        context.addPath(path)

        context.setStrokeColor(lineColor.cgColor)
        context.setLineWidth(rect.height)

        context.setLineDash(phase: 0, lengths: [line, space])
        context.strokePath()

        context.fillPath()
    }

    private func hPath(_ rect: CGRect) -> CGMutablePath {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: rect.height / 2))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height / 2))
        return path
    }

    private func vPath(_ rect: CGRect) -> CGMutablePath {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: rect.width / 2, y: 0))
        path.addLine(to: CGPoint(x: rect.width / 2, y: rect.height))
        return path
    }
}

@IBDesignable
class DottedLineBorder: CornerView {

    @IBInspectable var lineColor: UIColor = UIColor(hex: 0xE9E9E9)

    @IBInspectable var line: CGFloat = 2
    @IBInspectable var space: CGFloat = 3

    override func draw(_ rect: CGRect) {
        // 获取上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        // 画虚线
        /**设置起始和结束位置**/
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        context.addPath(path.cgPath)

        context.setStrokeColor(lineColor.cgColor)
        context.setLineWidth(1)

        context.setLineDash(phase: 0, lengths: [line, space])
        context.strokePath()
    }
}
