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

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.dataSource = self
        return tableView
    }()

    var post: Post?
    var onPostUpdate: ((Post) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        navigationItem.rightBarButtonItem = barButtonItem
        title = post?.title
        view.addSubview(tableView)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func barButtonPressed() {
        let infoViewController = InfoViewController()
        present(infoViewController, animated: true)
    }
}

extension PostViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        post == nil ? 0 : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        cell.onLikeTap = { [weak self] in
            guard let self else { return }
            self.post?.likes += 1
            if let post = self.post {
                cell.setup(post: post)
                self.onPostUpdate?(post)
            }
        }
        if let post { cell.setup(post: post) }
        return cell
    }
}
