//
//  EGStackView.swift
//  
//
//  Created by youzy01 on 2020/10/23.
//

import UIKit

public protocol Nesteable: NSObject {
    var scrollView: UIScrollView? { get }
    var contentSizeDidChanged: (() -> Void)? { get set }
}

/// 多视图(包含滚动视图)垂直排列，cell可复用
///
/// ArrangedSubview 需实现 intrinsicContentSize，提供一个默认高度
public final class EGStackView: UIScrollView {
    private lazy var contentView = UIView()

    private var subviewsInLayoutOrder: [UIView & Nesteable] = []

    deinit {
        debugPrint("EGStackView_deinit")
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        prepare()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepare()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = bounds
        contentView.bounds = CGRect(origin: contentOffset, size: contentView.bounds.size)
        // 整体内容高度
        var offsetyOfCurrentSubview: CGFloat = 0

        for subview in subviewsInLayoutOrder {
            var subFrame = subview.frame
            if subview.isHidden {
                var frame = subview.frame
                frame.origin.y = offsetyOfCurrentSubview
                frame.origin.x = 0
                frame.size.width = self.contentView.bounds.size.width
                subview.frame = frame

                // Do not set the height to zero. Just don't add the original height to yOffsetOfCurrentSubview.
                // This is to keep the original height when the view is unhidden.
                continue;
            }

            // 如果是滚动视图
            if let scrollView = subview.scrollView {
                var subContentOffset = scrollView.contentOffset
                if contentOffset.y < offsetyOfCurrentSubview {
                    subContentOffset.y = 0
                    subFrame.origin.y = offsetyOfCurrentSubview
                } else {
                    subContentOffset.y = contentOffset.y - offsetyOfCurrentSubview
                    subFrame.origin.y = contentOffset.y
                }

                let normalHeight = subview.intrinsicContentSize.height
                let remainingBoundsHeight = fmax(bounds.maxY - subFrame.minY, normalHeight)
                let remainingContentHeight = fmax(scrollView.contentSize.height - subContentOffset.y, normalHeight)

                subFrame.size.height = fmin(remainingBoundsHeight, remainingContentHeight)
                subFrame.size.width = contentView.bounds.width

                subview.frame = subFrame
                scrollView.contentOffset = subContentOffset

                offsetyOfCurrentSubview += (scrollView.contentSize.height + scrollView.contentInset.top + scrollView.contentInset.bottom)
            } else {
                subFrame.origin.y = offsetyOfCurrentSubview
                subFrame.origin.x = 0
                subFrame.size.width = contentView.bounds.width
                subFrame.size.height = subview.intrinsicContentSize.height
                subview.frame = subFrame

                offsetyOfCurrentSubview += subFrame.size.height
            }
        }

        let minimumContentHeight = bounds.size.height - (contentInset.top + contentInset.bottom)
        let initialContentOffset = contentOffset
        contentSize = CGSize(width: bounds.width, height: fmax(offsetyOfCurrentSubview, minimumContentHeight))

        if initialContentOffset != contentOffset {
            setNeedsLayout()
        }
    }
}

public extension EGStackView {
    func addArrangedSubview<V>(_ view: V) where V: UIView, V: Nesteable {
        contentView.addSubview(view)
        subviewsInLayoutOrder.append(view)
        view.contentSizeDidChanged = { [weak self] in
            self?.setNeedsLayout()
        }
    }

    func scrollToView<V>(_ view: V, animated: Bool) where V: UIView, V: Nesteable {
//        guard let subView = subviewsInLayoutOrder.first(where: { $0 == view }) else  { return }
        var y: CGFloat = 0
        for subView in subviewsInLayoutOrder {
            if view == subView {
                break
            }
            if let scrollView = subView.scrollView {
                 y += scrollView.contentSize.height
            } else {
                y += subView.frame.height
            }
        }
        debugPrint("滚动到: ", y)
        setContentOffset(CGPoint(x: 0, y: y), animated: animated)
    }

    func reload() {
        setNeedsLayout()
    }
}

private extension EGStackView {
    func prepare() {
        addSubview(contentView)
    }
}
