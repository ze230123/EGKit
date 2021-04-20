//
//  BaseWebViewController.swift
//  
//
//  Created by youzy01 on 2021/3/16.
//

import UIKit
import WebKit

open class BaseWebViewController: BaseViewController {
    public lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let view = WKWebView(frame: .zero, configuration: configuration)
        view.navigationDelegate = self
        return view
    }()

    lazy var progressView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .bar)
        return view
    }()

    private var progressObservation: NSKeyValueObservation?
    private var titleObservation: NSKeyValueObservation?

    private let url: String
    private let isChangeTitle: Bool

    private let customTitle: String

    public init(title: String = "", url: String) {
        self.url = url
        isChangeTitle = title.isEmpty
        customTitle = title
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        if #available(iOS 11, *) {
            return
        }
        progressObservation?.invalidate()
        progressObservation = nil
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadRequest()
    }

    open func loadRequest() {
        let request = URLRequest(url: URL(string: url)!)
        webView.load(request)
    }
}

private extension BaseWebViewController {
    func setup() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                webView.leftAnchor.constraint(equalTo: view.leftAnchor),
                webView.rightAnchor.constraint(equalTo: view.rightAnchor),
                webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
                webView.leftAnchor.constraint(equalTo: view.leftAnchor),
                webView.rightAnchor.constraint(equalTo: view.rightAnchor),
                webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }

        progressView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressView)
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                progressView.leftAnchor.constraint(equalTo: view.leftAnchor),
                progressView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                progressView.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
                progressView.leftAnchor.constraint(equalTo: view.leftAnchor),
                progressView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
        }

        progressObservation = webView.observe(\.estimatedProgress) { [weak progressView] (view, _) in
            progressView?.setProgress(Float(view.estimatedProgress), animated: true)
            print(view.estimatedProgress)
        }

        if isChangeTitle {
            titleObservation = webView.observe(\.title) { [weak self] (view, _) in
                self?.title = view.title
            }
        } else {
            title = customTitle
        }
    }

    /// 显示进度条
    func showProgressView() {
        progressView.isHidden = false
    }

    /// 隐藏进度条
    func hideProgressView() {
        UIView.animate(withDuration: 0.3) {
            self.progressView.isHidden = true
        } completion: { (_) in
            self.progressView.setProgress(0, animated: false)
        }
    }
}

extension BaseWebViewController: WKNavigationDelegate {
    @available(iOS 13.0, *)
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
        print("决定是允许还是取消导航。iOS 13")
        decisionHandler(.allow, preferences)
    }

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("决定是允许还是取消导航。")
        decisionHandler(.allow)
    }

    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("webView 开始导航")
        showProgressView()
    }

    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("webView 已收到请求的服务器重定向。")
    }

    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("webView 开始加载内容")
    }

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("webView 导航已完成")
        hideProgressView()
    }

    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("导航期间发生错误。")
    }

    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("早期导航过程中发生了错误。")
        hideProgressView()
    }

    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print("该Web视图的内容过程已终止。")
    }
}
