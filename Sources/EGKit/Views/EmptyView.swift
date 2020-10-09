//
//  EmptyView.swift
//  
//
//  Created by youzy01 on 2020/9/25.
//

import UIKit

class EmptyView: UIView, ViewEmptyable {
    lazy var label = UILabel()

    deinit {
        print("EmptyView_deinit")
    }

    init() {
        super.init(frame: .zero)
        setup()
    }

    private override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateTitle(_ title: String) {
        label.text = title
    }

    func updateContent(_ content: String) {
    }
}

extension EmptyView {
    func setup() {
        backgroundColor = .orange

        label.text = "没有数据"
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}

extension EmptyView: DataEmptyable {
    func update(title: String) {
        label.text = title
    }

    func update(content: String) {
    }

    func update(image: UIImage?) {
    }
}
