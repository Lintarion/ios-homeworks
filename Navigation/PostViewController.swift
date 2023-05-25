//
//  PostViewController.swift
//  Navigation
//
//  Created by Ирина Савостьянова on 24.04.2023.
//

import UIKit

class PostViewController: UIViewController {
    private lazy var barButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "Инфо", style: .plain, target: self, action: #selector(barButtonPressed))
        return item
    }()

    var post: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        navigationItem.rightBarButtonItem = barButtonItem
    }

    @objc private func barButtonPressed() {
        let infoViewController = InfoViewController()
        present(infoViewController, animated: true)
    }
}
