//
//  CornerView.swift
//  
//
//  Created by dev-02 on 2020/12/25.
//

import UIKit

/// 圆角View
@IBDesignable
public class CornerView: UIView {
    @IBInspectable public var isRadius: Bool = false

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

    public override func layoutSubviews() {
        super.layoutSubviews()
        if isRadius {
            layer.cornerRadius = frame.height / 2
        }
    }
}

@IBDesignable
public class BorderView: CornerView {
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
