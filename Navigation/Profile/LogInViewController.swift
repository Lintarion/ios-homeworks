//
//  LogInViewController.swift
//  Navigation
//
//  Created by Ирина Савостьянова on 16.05.2023.
//

import UIKit

class LogInViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo")
        return imageView
    }()

    private let inputsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = Constants.inputsBorderWidth
        stackView.layer.cornerRadius = 10
        stackView.distribution = .fillProportionally
        stackView.clipsToBounds = true
        return stackView
    }()

    private lazy var emailOrPhoneTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(emailOrPhoneTextChanged(_:)), for: .editingChanged)
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .black
        textField.tintColor = UIColor(named: "AccentColor")
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 10, height: 10)))
        textField.rightViewMode = .always
        textField.rightView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 10, height: 10)))
        textField.setPlaceholder(Constants.emailOrPhonePlaceholder, isError: false)
        textField.delegate = self
        textField.returnKeyType = .next
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(passwordTextChanged(_:)), for: .editingChanged)
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .black
        textField.tintColor = UIColor(named: "AccentColor")
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 10, height: 10)))
        textField.rightViewMode = .always
        textField.rightView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 10, height: 10)))
        textField.setPlaceholder(Constants.passwordPlaceholder, isError: false)
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.returnKeyType = .done
        return textField
    }()

    private let inputsSeparator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()

    private let hintLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        label.textColor = .red
        label.text = "Password should be at least \(Constants.passwordLength) symbols long"
        label.isHidden = true
        return label
    }()

    private lazy var logInButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Log In"
        config.baseForegroundColor = .white
        config.background.image = UIImage(named: "blue_pixel")
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
        button.configurationUpdateHandler = { button in
            switch button.state {
            case .normal:
                button.alpha = 1
            case .selected, .highlighted, .disabled:
                button.alpha = 0.8
            default:
                button.alpha = 1
            }
        }
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logoImageView)
        contentView.addSubview(inputsStackView)
        inputsStackView.addArrangedSubview(emailOrPhoneTextField)
        inputsStackView.addArrangedSubview(inputsSeparator)
        inputsStackView.addArrangedSubview(passwordTextField)
        contentView.addSubview(hintLabel)
        contentView.addSubview(logInButton)
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObservers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.logoTopOffset),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: Constants.logoSize),
            logoImageView.heightAnchor.constraint(equalToConstant: Constants.logoSize),

            inputsStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: Constants.inputsContainerTopOffset),
            inputsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalOffset),
            inputsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalOffset),
            inputsStackView.heightAnchor.constraint(equalToConstant: Constants.inputsContainerHeight),
            inputsSeparator.heightAnchor.constraint(equalToConstant: Constants.inputsBorderWidth),

            hintLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalOffset),
            hintLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalOffset),
            hintLabel.topAnchor.constraint(equalTo: inputsStackView.bottomAnchor, constant: 2),

            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalOffset),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalOffset),
            logInButton.topAnchor.constraint(equalTo: inputsStackView.bottomAnchor, constant: Constants.logInButtonTopOffset),
            logInButton.heightAnchor.constraint(equalToConstant: Constants.logInButtonHeight),
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(willShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(willHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func willShowKeyboard(_ notification: Notification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        scrollView.contentInset.bottom = keyboardHeight ?? 0
    }

    @objc private func willHideKeyboard(_ notification: Notification) {
        scrollView.contentInset.bottom = 0
    }

    @objc private func emailOrPhoneTextChanged(_ textField: UITextField) {
        textField.setPlaceholder(Constants.emailOrPhonePlaceholder, isError: false)
    }

    @objc private func passwordTextChanged(_ textField: UITextField) {
        textField.setPlaceholder(Constants.passwordPlaceholder, isError: false)
        hintLabel.isHidden = true
    }

    @objc private func logInButtonPressed() {
        let emailOrPhone = emailOrPhoneTextField.text ?? ""
        let isEmailOrPhoneEmpty = emailOrPhone.isEmpty
        if isEmailOrPhoneEmpty { emailOrPhoneTextField.setPlaceholder(Constants.emailOrPhonePlaceholder, isError: true) }
        let password = passwordTextField.text ?? ""
        let isPasswordEmpty = password.isEmpty
        if isPasswordEmpty { passwordTextField.setPlaceholder(Constants.passwordPlaceholder, isError: true) }

        if isEmailOrPhoneEmpty || isPasswordEmpty { return }

        guard password.count >= Constants.passwordLength else {
            hintLabel.isHidden = false
            return
        }

        guard emailOrPhone == Constants.defaultLogin, password == Constants.defaultPassword else {
            let alert = UIAlertController(title: "Error", message: "Login or password is incorrect", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
            return
        }

        view.endEditing(true)
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailOrPhoneTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension LogInViewController {
    private enum Constants {
        static let logoTopOffset: CGFloat = 120
        static let logoSize: CGFloat = 100
        static let horizontalOffset: CGFloat = 16
        static let inputsContainerTopOffset: CGFloat = 120
        static let inputsContainerHeight: CGFloat = 100
        static let inputsBorderWidth: CGFloat = 0.5
        static let logInButtonTopOffset: CGFloat = 16
        static let logInButtonHeight: CGFloat = 50
        static let emailOrPhonePlaceholder: String = "Email or phone"
        static let passwordPlaceholder: String = "Password"
        static let passwordLength: Int = 6

        static let defaultLogin: String = "admin"
        static let defaultPassword: String = "passw0rd"
    }
}
