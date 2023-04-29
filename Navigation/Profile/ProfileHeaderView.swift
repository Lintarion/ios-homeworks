//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Ирина Савостьянова on 26.04.2023.
//

import UIKit

class ProfileHeaderView: UIView {
    private enum Constants {
        static let horizontalOffset: CGFloat = 16
        static let avatarTopOffset: CGFloat = 16
        static let avatarSize: CGFloat = 100
        static let buttonTopOffset: CGFloat = 16
        static let buttonHeight: CGFloat = 50
        static let labelsLeadingOffset: CGFloat = 16
        static let titleLabelTopOffset: CGFloat = 27
        static let statusLabelBottomOffset: CGFloat = 34
    }

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "avatar")
        return imageView
    }()

    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "Hipster Cat"
        return label
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.text = "Waiting for something..."
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        addSubview(avatarImageView)
        addSubview(button)
        addSubview(titleLabel)
        addSubview(statusLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupAvatarFrame()
        setupButtonFrame()
        setupLabelsFrames()
    }

    private func setupAvatarFrame() {
        avatarImageView.frame = CGRect(x: Constants.horizontalOffset,
                                       y: Constants.avatarTopOffset + safeAreaInsets.top,
                                       width: Constants.avatarSize,
                                       height: Constants.avatarSize)
    }

    private func setupButtonFrame() {
        button.frame = CGRect(x: Constants.horizontalOffset,
                              y: avatarImageView.frame.maxY + Constants.buttonTopOffset,
                              width: frame.size.width - 2 * Constants.horizontalOffset,
                              height: Constants.buttonHeight)
    }

    private func setupLabelsFrames() {
        titleLabel.frame.origin.x = avatarImageView.frame.maxX + Constants.labelsLeadingOffset
        titleLabel.frame.size.width = frame.size.width - Constants.horizontalOffset - titleLabel.frame.minX
        titleLabel.sizeToFit()
        titleLabel.frame.origin.y = Constants.titleLabelTopOffset + safeAreaInsets.top

        statusLabel.frame.origin.x = titleLabel.frame.origin.x
        statusLabel.frame.size.width = titleLabel.frame.size.width
        statusLabel.sizeToFit()
        statusLabel.frame.origin.y = button.frame.minY - Constants.statusLabelBottomOffset - statusLabel.frame.height
    }

    @objc private func buttonPressed() {
        print(statusLabel.text ?? "")
    }
}
