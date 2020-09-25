//
//  RefreshNormalFooter.swift
//  SwiftPackageDemo
//
//  Created by youzy01 on 2020/9/24.
//  Copyright © 2020 优志愿. All rights reserved.
//

import UIKit

public class RefreshNormalFooter: RefreshFooter {
    lazy var label = UILabel()
    lazy var indicator = UIActivityIndicatorView()

    lazy var errorButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        return button
    }()

    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 5
        return stack
    }()

    public var retryBlock: (() -> Void)?

    override func prepare() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        stackView.addArrangedSubview(indicator)
        stackView.addArrangedSubview(label)
    }

    public override func stateDidChanged() {
        switch state {
        case .none, .pulling:
            label.text = "正在加载数据..."
            indicator.stopAnimating()
            indicator.isHidden = true
            stackView.isHidden = false
            errorButton.removeFromSuperview()
        case .refreshing:
            indicator.isHidden = false
            indicator.startAnimating()
            stackView.isHidden = false
        case .noMoreData:
            indicator.stopAnimating()
            indicator.isHidden = true
            label.text = "没有更多数据了~~"
        default:
            break
        }
    }

    public override func endRefresh(error: Error) {
        stackView.isHidden = true
        errorButton.frame = bounds
        errorButton.setTitle("\(error.localizedDescription)，点击重新加载", for: .normal)
        addSubview(errorButton)
    }

    @objc private func tapAction() {
        assert(retryBlock != nil, "重试闭包未赋值")
        stackView.isHidden = false
        errorButton.removeFromSuperview()
        retryBlock?()
    }
}
