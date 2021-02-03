//
//  UITableSectionHeader.swift
//  
//
//  Created by youzy01 on 2021/1/29.
//

import UIKit

public class UITableSectionHeader: UITableViewHeaderFooterView, CellConfigurable {
    @IBOutlet public weak var titleLabel: UILabel!

    public override func awakeFromNib() {
        let view = UIView()
        view.backgroundColor = .white
        backgroundView = view
    }

    public static var nib: UINib? {
        return UINib(nibName: reuseableIdentifier, bundle: Bundle.module)
    }

    public func configure(_ item: String) {
        titleLabel?.text = item
    }
}
