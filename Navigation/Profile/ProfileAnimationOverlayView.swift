//
//  ProfileAnimationOverlayView.swift
//  Navigation
//
//  Created by Ирина Савостьянова on 17.05.2023.
//

import UIKit

class ProfileAnimationOverlayView: UIView {
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
        button.addTarget(self, action: #selector(minimizeAvatar), for: .touchUpInside)
        button.alpha = 0
        return button
    }()

    private var headerView: ProfileHeaderView?

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

    func maximizeAvatar(headerView: ProfileHeaderView, rootView: UIView) {
        self.headerView = headerView
        rootView.addSubview(self)
        frame = rootView.bounds
        updateLayout()

        let avatarView = headerView.avatarImageView
        let avatarFrame = avatarView.convert(avatarView.bounds, to: rootView)
        avatarView.removeFromSuperview()
        addSubview(avatarView)
        avatarView.translatesAutoresizingMaskIntoConstraints = true
        avatarView.frame = avatarFrame
        let button = closeButton

        UIView.animate(withDuration: Constants.primaryAnimationDuration) {
            let scaledSize = rootView.frame.width - 2 * Constants.scaledAvatarSpacing
            let scale = scaledSize / avatarView.frame.width
            let scaleTransform = CGAffineTransform(scaleX: scale, y: scale)
            let translationX = rootView.frame.midX - avatarFrame.midX
            let translationY = rootView.frame.midY - avatarFrame.midY
            let translationTransform = CGAffineTransform(translationX: translationX, y: translationY)
            avatarView.transform = scaleTransform.concatenating(translationTransform)
            avatarView.layer.cornerRadius = 0
            self.backgroundView.alpha = 0.7
        } completion: { _ in
            UIView.animate(withDuration: Constants.secondaryAnimationDuration) {
                button.alpha = 1
            }
        }
    }

    @objc private func minimizeAvatar() {
        guard let headerView else { return }

        UIView.animate(withDuration: Constants.secondaryAnimationDuration) {
            self.closeButton.alpha = 0
        } completion: { [weak self] _ in
            guard let self else { return }
            UIView.animate(withDuration: Constants.primaryAnimationDuration) {
                self.backgroundView.alpha = 0
                headerView.avatarImageView.transform = .identity
                headerView.avatarImageView.layer.cornerRadius = headerView.avatarImageView.frame.width / 2
            } completion: { [weak self] _ in
                guard let self else { return }
                headerView.attachAvatar()
                self.removeFromSuperview()
                self.headerView = nil
            }
        }
    }
}

extension ProfileAnimationOverlayView {
    private enum Constants {
        static let scaledAvatarSpacing: CGFloat = 16
        static let closeButtonSize: CGFloat = 24
        static let closeButtonSpacing: CGFloat = 16
        static let primaryAnimationDuration: TimeInterval = 0.5
        static let secondaryAnimationDuration: TimeInterval = 0.3
    }
}
