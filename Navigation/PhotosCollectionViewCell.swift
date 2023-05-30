//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Ирина Савостьянова on 16.05.2023.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    let pictureView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
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
        attachPicture()
    }

    func setup(imageName: String) {
        pictureView.image = UIImage(named: imageName)
    }

    func attachPicture() {
        pictureView.removeFromSuperview()
        pictureView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pictureView)
        NSLayoutConstraint.activate([
            pictureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pictureView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pictureView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pictureView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
