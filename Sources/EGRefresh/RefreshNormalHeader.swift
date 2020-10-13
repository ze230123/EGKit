//
//  RefreshNormalHeader.swift
//  SwiftPackageDemo
//
//  Created by youzy01 on 2020/9/22.
//  Copyright © 2020 优志愿. All rights reserved.
//

import UIKit

public class RefreshNormalHeader: RefreshHeader {
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    lazy var indicator = UIActivityIndicatorView()

//    lazy var imageView = UIImageView(image: UIImage(named: "arrow"))
    lazy var imageView: UIImageView = {
        let image = UIImage(named: "arrow", in: Bundle.module, compatibleWith: nil)
        let view = UIImageView(image: image)
        return view
    }()

    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 5
        return stack
    }()

    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .red
        label.textAlignment = .center
        return label
    }()

    //加载xib
    func loadViewFromNib() -> UIView {
        let className = type(of: self)
        let bundle = Bundle(for: className)
        let name = NSStringFromClass(className).components(separatedBy: ".").last
        let nib = UINib(nibName: name!, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }

    override func prepare() {
        backgroundColor = .clear

        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        stackView.addArrangedSubview(indicator)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
    }

    public override func stateDidChanged() {
        switch state {
        case .none, .pulling:
            label.text = "下拉刷新"
            label.isHidden = false
            stackView.isHidden = false
            errorLabel.removeFromSuperview()
            indicator.isHidden = true
            indicator.stopAnimating()

            imageView.isHidden = false
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.imageView.transform = .identity
            }
        case .ready:
            label.text = "释放刷新"
            UIView.animate(withDuration: 0.2) { [weak imageView] in
//                DispatchQueue.main.async {
                    imageView?.transform = CGAffineTransform(rotationAngle: 0.000001 - .pi)
//                }
            }
        case .refreshing:
            stackView.isHidden = false
            label.isHidden = false
            label.text = "正在刷新..."
            indicator.startAnimating()
            indicator.isHidden = false
            imageView.isHidden = true
        case .finish:
            indicator.stopAnimating()
            stackView.isHidden = true
        default:
            break
        }
    }

    public override func endRefresh(error: Error) {
        state = .finish

        errorLabel.text = error.localizedDescription
        errorLabel.frame = bounds
        errorLabel.alpha = 0
        addSubview(errorLabel)

        func endAnimate() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.endRefresh()
            }
        }

        UIView.animate(withDuration: 0.5) { [unowned errorLabel] in
            errorLabel.alpha = 1
        } completion: { (_) in
            endAnimate()
        }
    }
}
