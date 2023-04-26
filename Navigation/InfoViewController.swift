//
//  InfoViewController.swift
//  Navigation
//
//  Created by Ирина Савостьянова on 24.04.2023.
//

import UIKit

class InfoViewController: UIViewController {
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Показать Alert", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(button)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func buttonPressed() {
        let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        let firstAction = UIAlertAction(title: "OK", style: .default) { _ in
            print("OK pressed")
        }
        alertController.addAction(firstAction)
        let secondAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel pressed")
        }
        alertController.addAction(secondAction)
        present(alertController, animated: true)
    }
}
