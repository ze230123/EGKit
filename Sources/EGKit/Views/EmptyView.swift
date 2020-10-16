//
//  EmptyView.swift
//  
//
//  Created by youzy01 on 2020/9/25.
//

import UIKit

class EmptyView: UIView {
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .center
        view.distribution = .fill
        view.axis = .vertical
        view.spacing = 5
        return view
    }()

    let imageView = UIImageView()
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()

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
}

private extension EmptyView {
    func setup() {
        backgroundColor = UIColor.clear

        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "icon_list_empty")

        titleLabel.textColor = UIColor.lightGray
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        subTitleLabel.textColor = UIColor.lightGray
        subTitleLabel.numberOfLines = 0
        subTitleLabel.font = UIFont.systemFont(ofSize: 12)

        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}

extension EmptyView: DataEmptyable {
    func update(title: String) {
        titleLabel.text = title
    }

    func update(content: String) {
        subTitleLabel.text = content
    }

    func update(image: UIImage?) {
        imageView.image = image
    }
}
