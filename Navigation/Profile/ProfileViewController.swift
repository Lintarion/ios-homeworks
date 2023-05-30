//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Ирина Савостьянова on 24.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    private let headerView = ProfileHeaderView()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    private lazy var animationOverlayView: AnimationOverlayView = {
        let view = AnimationOverlayView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var posts = Post.mockArray
    private let photos: [String] = {
        var result: [String] = []
        for i in 1...20 { result.append("animal_\(i)") }
        return result
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setupConstraints()
        setupAvatarTap()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupAvatarTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleAvatarTap))
        headerView.avatarImageView.isUserInteractionEnabled = true
        headerView.avatarImageView.addGestureRecognizer(tapGesture)
    }

    @objc private func handleAvatarTap() {
        guard let rootView = tabBarController?.view else { return }
        animationOverlayView.maximizeView(view: headerView.avatarImageView, rootView: rootView, changeCornerRadius: true) { [weak self] in
            self?.headerView.attachAvatar()
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return headerView
        } else {
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return Constants.headerHeight
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let photosVC = PhotosViewController()
            photosVC.imageNames = photos
            navigationController?.pushViewController(photosVC, animated: true)
        } else if indexPath.section == 1 {
            posts[indexPath.row].views += 1
            tableView.reloadRows(at: [indexPath], with: .none)
            let postViewController = PostViewController()
            postViewController.post = posts[indexPath.row]
            postViewController.onPostUpdate = { [weak self] post in
                guard let self else { return }
                self.posts[indexPath.row] = post
                tableView.reloadRows(at: [indexPath], with: .none)
            }
            present(UINavigationController(rootViewController: postViewController), animated: true)
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return posts.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as! PhotosTableViewCell
            cell.setup(imageNames: photos)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
            cell.onLikeTap = { [weak self] in
                guard let self else { return }
                self.posts[indexPath.row].likes += 1
                cell.setup(post: self.posts[indexPath.row])
            }
            cell.setup(post: posts[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension ProfileViewController {
    private enum Constants {
        static let headerHeight: CGFloat = 220
    }
}
