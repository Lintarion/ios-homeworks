//
//  AnimationOverlayView.swift
//  Navigation
//
//  Created by Ирина Савостьянова on 17.05.2023.
//

import UIKit

class AnimationOverlayView: UIView {
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = .lightGray
        return view
    }()

    private lazy var closeButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "xmark")
        config.baseForegroundColor = .black
        let button = UIButton(configuration: config)
        button.addTarget(self, action: #selector(minimizeView), for: .touchUpInside)
        button.alpha = 0
        return button
    }()

    private var onComplete: (() -> Void)?
    private var viewToAnimate: UIView?
    private var changeCornerRadius: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let view = closeButton.hitTest(convert(point, to: closeButton), with: event) {
            return view
        }
        return self
    }

    private func commonInit() {
        addSubview(backgroundView)
        addSubview(closeButton)
    }

    private func updateLayout() {
        backgroundView.frame = bounds
        closeButton.frame = CGRect(
            x: bounds.width - Constants.closeButtonSpacing - Constants.closeButtonSize,
            y: safeAreaInsets.top + Constants.closeButtonSpacing,
            width: Constants.closeButtonSize,
            height: Constants.closeButtonSize
        )
    }

    func maximizeView(view: UIView, rootView: UIView, changeCornerRadius: Bool, onComplete: (() -> Void)?) {
        self.onComplete = onComplete
        self.viewToAnimate = view
        self.changeCornerRadius = changeCornerRadius
        rootView.addSubview(self)
        frame = rootView.bounds
        updateLayout()

        let viewFrame = view.convert(view.bounds, to: rootView)
        view.removeFromSuperview()
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = true
        view.frame = viewFrame
        let button = closeButton

        UIView.animate(withDuration: Constants.primaryAnimationDuration) {
            let scaledSize = rootView.frame.width - 2 * Constants.scaledAvatarSpacing
            let scale = scaledSize / view.frame.width
            let scaleTransform = CGAffineTransform(scaleX: scale, y: scale)
            let translationX = rootView.frame.midX - viewFrame.midX
            let translationY = rootView.frame.midY - viewFrame.midY
            let translationTransform = CGAffineTransform(translationX: translationX, y: translationY)
            view.transform = scaleTransform.concatenating(translationTransform)
            if changeCornerRadius { view.layer.cornerRadius = 0 }
            self.backgroundView.alpha = 0.7
        } completion: { _ in
            UIView.animate(withDuration: Constants.secondaryAnimationDuration) {
                button.alpha = 1
            }
        }
    }

    @objc private func minimizeView() {
        guard let view = viewToAnimate else { return }
        UIView.animate(withDuration: Constants.secondaryAnimationDuration) {
            self.closeButton.alpha = 0
        } completion: { [weak self] _ in
            guard let self else { return }
            UIView.animate(withDuration: Constants.primaryAnimationDuration) {
                self.backgroundView.alpha = 0
                view.transform = .identity
                if self.changeCornerRadius { view.layer.cornerRadius = view.frame.width / 2 }
            } completion: { [weak self] _ in
                guard let self else { return }
                self.onComplete?()
                self.removeFromSuperview()
                self.viewToAnimate = nil
                self.onComplete = nil
                self.changeCornerRadius = false
            }
        }
    }
}

extension AnimationOverlayView {
    private enum Constants {
        static let scaledAvatarSpacing: CGFloat = 16
        static let closeButtonSize: CGFloat = 24
        static let closeButtonSpacing: CGFloat = 16
        static let primaryAnimationDuration: TimeInterval = 0.5
        static let secondaryAnimationDuration: TimeInterval = 0.3
    }
}
