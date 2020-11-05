//
//  File.swift
//  
//
//  Created by youzy01 on 2020/10/9.
//

import MBProgressHUD
/// HUD 提示
public struct HUD {
    /// hud隐藏完成
    public typealias Completion = () -> Void

    private let hud: MBProgressHUD
    private weak var view: UIView?

    init(hud: MBProgressHUD, view: UIView) {
        self.hud = hud
        self.view = view
    }

    public func show(animated: Bool = true) {
        view?.addSubview(hud)
        hud.show(animated: animated)
    }

    public func hide(animated: Bool = true) {
        hud.hide(animated: true)
    }
}

extension HUD {
    private static func updateLoadingHud(_ hud: MBProgressHUD) {
        hud.mode = .customView
        let loadview = LoadingView()
        loadview.start()
        hud.customView = loadview
        hud.label.text = "加载中..."
        hud.backgroundView.style = .solidColor
        hud.backgroundView.color = UIColor(white: 0, alpha: 0.3)
        hud.bezelView.style = .solidColor
        hud.bezelView.color = UIColor.white
    }

    static func loading(to view: UIView) -> HUD {
        let hud = MBProgressHUD(view: view)
        updateLoadingHud(hud)
        return HUD(hud: hud, view: view)
    }
}


extension HUD {
    /// 显示全屏HUD
    /// - Parameters:
    ///   - message: 信息
    ///   - animated: 是否动画
    ///   - delay: 延迟时间
    ///   - completion: 完成闭包
    public static func show(
        _ message: String,
        to View: UIView? = nil,
        animated: Bool = true,
        delay: TimeInterval = 3,
        completion: Completion? = nil)
    {
        guard let view = UIApplication.shared.keyWindow else { return }

        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.bezelView.style = .solidColor
        hud.bezelView.color = UIColor(white: 0, alpha: 0.8)

        hud.completionBlock = completion

        // 隐藏时候从父控件中移除
        hud.mode = .text
        hud.label.text = message
        hud.label.textColor = .white
        hud.label.numberOfLines = 0

        hud.hide(animated: animated, afterDelay: delay)
    }
}

extension HUD {
    public enum Position {
        case top
        case center
        case bottom
    }

    public static func showMessage(_ text: String, to view: UIView?, animated: Bool = true, position: Position = .center, delay: TimeInterval = 2) {
        guard let view = view else { return }

        let hud = MBProgressHUD.showAdded(to: view, animated: animated)
        hud.bezelView.style = .solidColor
        hud.bezelView.color = UIColor(white: 0, alpha: 0.8)

        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = true
        hud.mode = .text
        hud.label.text = text
        hud.label.textColor = .white
        hud.label.numberOfLines = 0

        switch position {
        case .top:
            hud.offset = CGPoint(x: 0, y: -200)
        case .center:
            hud.offset = CGPoint(x: 0, y: 0)
        case .bottom:
            hud.offset = CGPoint(x: 0, y: MBProgressMaxOffset)
        }
        hud.hide(animated: animated, afterDelay: delay)
    }

    public static func showTips(_ text: String, to view: UIView, delay: TimeInterval = 3) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.bezelView.style = .solidColor
        hud.bezelView.color = UIColor(white: 0, alpha: 0.8)

        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = true
        hud.mode = .text
        hud.label.text = text
        hud.label.textAlignment = .left
        hud.label.textColor = .white
        hud.label.numberOfLines = 0

        hud.hide(animated: true, afterDelay: delay)
    }
}
