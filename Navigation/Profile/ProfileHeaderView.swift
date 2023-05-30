//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Ирина Савостьянова on 26.04.2023.
//

import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    private let avatarContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "avatar")
        return imageView
    }()

    private lazy var setStatusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(setStatusButtonPressed), for: .touchUpInside)
        return button
    }()

    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "Hipster Cat"
        return label
    }()

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.text = statusText
        return label
    }()

    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 10, height: 10)))
        textField.rightViewMode = .always
        textField.rightView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 10, height: 10)))
        textField.delegate = self
        textField.setPlaceholder(Constants.statusPlaceholder, isError: false)
        return textField
    }()

    private var statusText: String = "Waiting for something..."

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(statusTextField)
        addSubview(setStatusButton)
        addSubview(avatarContainer)
        setupConstraints()
        attachAvatar()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalOffset),
            avatarContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.avatarTopOffset),
            avatarContainer.widthAnchor.constraint(equalToConstant: Constants.avatarSize),
            avatarContainer.heightAnchor.constraint(equalToConstant: Constants.avatarSize),

            fullNameLabel.leadingAnchor.constraint(equalTo: avatarContainer.trailingAnchor, constant: Constants.labelsLeadingOffset),
            fullNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.titleLabelTopOffset),
            fullNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalOffset),

            statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor),

            statusTextField.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: Constants.statusTextFieldTopOffset),
            statusTextField.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor),
            statusTextField.heightAnchor.constraint(equalToConstant: Constants.statusTextFieldHeight),

            setStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalOffset),
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: Constants.buttonTopOffset),
            setStatusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalOffset),
            setStatusButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            setStatusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.bottomButtonOffset)
        ])
    }

    @objc private func setStatusButtonPressed() {
        let statusText = statusTextField.text ?? ""
        if statusText.isEmpty {
            statusTextField.setPlaceholder(Constants.statusPlaceholder, isError: true)
            return
        }
        self.statusText = statusText
        statusLabel.text = statusText
    }

    @objc private func statusTextChanged(_ textField: UITextField) {
        statusTextField.setPlaceholder(Constants.statusPlaceholder, isError: false)
    }

    func attachAvatar() {
        avatarImageView.removeFromSuperview()
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarContainer.addSubview(avatarImageView)
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: avatarContainer.leadingAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: avatarContainer.trailingAnchor),
            avatarImageView.topAnchor.constraint(equalTo: avatarContainer.topAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: avatarContainer.bottomAnchor)
        ])
    }
}

extension ProfileHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ProfileHeaderView {
    private enum Constants {
        static let horizontalOffset: CGFloat = 16
        static let avatarTopOffset: CGFloat = 16
        static let avatarSize: CGFloat = 100
        static let buttonTopOffset: CGFloat = 16
        static let buttonHeight: CGFloat = 50
        static let labelsLeadingOffset: CGFloat = 16
        static let titleLabelTopOffset: CGFloat = 27
        static let statusTextFieldTopOffset: CGFloat = 16
        static let statusTextFieldHeight: CGFloat = 40
        static let bottomButtonOffset: CGFloat = 16
        static let statusPlaceholder: String = "Set status"
    }
}
