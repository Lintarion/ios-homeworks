//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Ирина Савостьянова on 16.05.2023.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.text = "Photos"
        return label
    }()

    private let arrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.right"))
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let imagesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Constants.stackSpacing
        return stackView
    }()

    private let imageViews: [UIImageView] = {
        var result: [UIImageView] = []
        for _ in 0..<Constants.imageCount {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.cornerRadius = 6
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            result.append(imageView)
        }
        return result
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        selectionStyle = .none
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowImageView)
        contentView.addSubview(imagesStackView)
        imageViews.forEach { imagesStackView.addArrangedSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.spacing),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spacing),

            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.spacing),
            arrowImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: Constants.arrowImageSize),
            arrowImageView.heightAnchor.constraint(equalToConstant: Constants.arrowImageSize),

            imagesStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.spacing),
            imagesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spacing),
            imagesStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.spacing),
            imagesStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.spacing)
        ])

        imageViews.forEach {
            NSLayoutConstraint.activate([
                $0.heightAnchor.constraint(equalTo: $0.widthAnchor)
            ])
        }
    }

    func setup(imageNames: [String]) {
        imageViews.forEach { $0.image = nil }
        imageNames.indices.forEach { index in
            if index < Constants.imageCount {
                imageViews[index].image = UIImage(named: imageNames[index])
            }
        }
    }
}

extension PhotosTableViewCell {
    private enum Constants {
        static let spacing: CGFloat = 12
        static let stackSpacing: CGFloat = 8
        static let imageCount: Int = 4
        static let arrowImageSize: CGFloat = 20
    }
}
