//
//  CornerImageView.swift
//  
//
//  Created by dev-02 on 2020/12/29.
//

import UIKit

@IBDesignable
public class CornerImageView: UIImageView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
