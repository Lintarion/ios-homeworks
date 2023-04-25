//
//  PostViewController.swift
//  Navigation
//
//  Created by Ирина Савостьянова on 24.04.2023.
//

import UIKit

class PostViewController: UIViewController {
    var post: Post?

    override func loadView() {
        super.loadView()
        view.backgroundColor = .lightGray
        title = post?.title ?? "Пост"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Инфо", primaryAction: UIAction(handler: { [weak self] _ in
            let infoViewController = InfoViewController()
            self?.present(infoViewController, animated: true)
        }))
    }
}
