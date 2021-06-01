//
//  BaseWebViewController.swift
//  
//
//  Created by youzy01 on 2021/3/16.
//

import UIKit
import WebKit

open class ScriptHandler: NSObject {
    public let name: String
    private let handler: ((WKScriptMessage) -> Void)?

    deinit {
        print("ScriptHandler_\(name)_deinit")
    }

    public init(name: String, handler: ((WKScriptMessage) -> Void)?) {
        self.name = name
        self.handler = handler
        super.init()
    }
}

extension ScriptHandler: WKScriptMessageHandler {
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        handler?(message)
    }
}

open class BaseWebViewController: BaseViewController {
    public lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true

        let view = WKWebView(frame: .zero, configuration: configuration)
        view.allowsLinkPreview = false
        view.navigationDelegate = self
        view.uiDelegate = self
        return view
    }()

    /// 进度条
    lazy var progressView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .bar)
        return view
    }()

    var userController: WKUserContentController {
        return webView.configuration.userContentController
    }

    /// 进度观察者
    private var progressObservation: NSKeyValueObservation?
    /// 标题观察者
    private var titleObservation: NSKeyValueObservation?

    private var scripts: [String] = []

    /// 要打开的URL
    private let url: String
    /// 是否改变标题
    private let isChangeTitle: Bool

    /// 自定义标题
    private let customTitle: String

    deinit {
        progressObservation?.invalidate()
        progressObservation = nil

        scripts.forEach { (name) in
            userController.removeScriptMessageHandler(forName: name)
        }
    }

    public init(title: String = "", url: String) {
        self.url = url
        isChangeTitle = title.isEmpty
        customTitle = title
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    open override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addJavaScript()
        loadRequest(value: url)
    }

    open func loadRequest(value: String) {
        let request = URLRequest(url: URL(string: value)!)
        webView.load(request)
    }

    open func addJavaScript() {

    }

    public final func addScriptHandler(_ item: ScriptHandler) {
        userController.add(item, name: item.name)
        scripts.append(item.name)
    }
}

extension BaseWebViewController: WKScriptMessageHandler {
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {

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
        print(navigationAction.request.url?.absoluteString ?? "url == nil")
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

// MARK: - WKUIDelegate
extension BaseWebViewController: WKUIDelegate {
    // 创建一个新的WebView
    public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        //如果是跳转一个新页面
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }

    // WebView关闭
    public func webViewDidClose(_ webView: WKWebView) {
//        print("WebView关闭")
    }

    // 显示一个JS的alert
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        print(message)
        // 确定按钮
        let alertAction = UIAlertAction(title: "OK", style: .cancel) { (_) in
            completionHandler()
        }
        // alert弹出框
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alertController.addAction(alertAction)

        present(alertController, animated: true, completion: nil)
    }

    // 弹出一个输入框
    public func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        print(prompt, defaultText)
    }

    // 弹出一个确认框
    public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        print(message)
    }
}
