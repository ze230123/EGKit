//
//  File.swift
//  
//
//  Created by dev-02 on 2020/12/28.
//
import UIKit

@IBDesignable
class BorderLabel: CornerLabel {
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
