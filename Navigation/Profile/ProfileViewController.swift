//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Ирина Савостьянова on 24.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    private let headerView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var setTitleButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitle("Set title", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(setTitleButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(headerView)
        view.addSubview(setTitleButton)
        title = "Profile"
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: Constants.headerHeight),
            setTitleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            setTitleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            setTitleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc private func setTitleButtonPressed() {
        
    }
}

extension ProfileViewController {
    private enum Constants {
        static let headerHeight: CGFloat = 220
    }
}
