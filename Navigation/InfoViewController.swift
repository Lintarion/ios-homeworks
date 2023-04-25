//
//  InfoViewController.swift
//  Navigation
//
//  Created by Ирина Савостьянова on 24.04.2023.
//

import UIKit

class InfoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let button = UIButton(primaryAction: UIAction(handler: { [weak self] _ in
            let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
            let firstAction = UIAlertAction(title: "OK", style: .default) { _ in
                print("OK pressed")
            }
            alertController.addAction(firstAction)
            let secondAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                print("Cancel pressed")
            }
            alertController.addAction(secondAction)
            self?.present(alertController, animated: true)
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Показать Alert", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
