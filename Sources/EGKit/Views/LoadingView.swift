//
//  LoadingView.swift
//  
//
//  Created by youzy01 on 2020/9/25.
//

import UIKit

class LoadingView: UIView, LoadAnimateable {
//    lazy var indicator = UIActivityIndicatorView(style: .gray)

    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "loading1")
        return view
    }()

    public var isLoading: Bool = true

    deinit {
        stop()
        print("LoadingView_deinit")
    }

    init() {
        super.init(frame: .zero)
        setup()
    }

    private override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func start() {
//        indicator.startAnimating()
        let image = UIImage.animatedImageNamed("loading", duration: 0.7)
        imageView.image = image
        isLoading = true
    }

    func stop() {
//        indicator.stopAnimating()
        imageView.image = UIImage(named: "loading1")
        isLoading = false
    }
}

extension LoadingView {
    func setup() {
        backgroundColor = .cyan

        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}

