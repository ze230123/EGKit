//
//  BorderLabel.swift
//  
//
//  Created by dev-02 on 2020/12/28.
//
import UIKit

@IBDesignable
public class BorderLabel: CornerLabel {
    @IBInspectable public var borderColor: UIColor? = UIColor.white {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
}
