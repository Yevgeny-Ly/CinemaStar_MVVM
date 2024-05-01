// ActorsCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка коллекции актеров фильма
final class ActorsCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants

    enum Constants {
        static var fontInterRegular = "Inter-Regular"
        static var fontInterSemiBold = "Inter-SemiBold"
    }

    // MARK: - Visual Components

    private let actorAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var nameActorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Constants.fontInterRegular, size: 8)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Public Properties

    static let identifier = NSStringFromClass(ActorsCollectionViewCell.self)

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview()
        setupConstraints()
    }

    // MARK: - Public Methods

    func configureCell(with model: Person) {
        actorAvatarImageView.downloaded(from: model.photo)
        nameActorLabel.text = model.name
    }

    // MARK: - Private Methods

    private func addSubview() {
        contentView.addSubview(actorAvatarImageView)
        contentView.addSubview(nameActorLabel)
    }

    private func setupConstraints() {
        actorAvatarConstraints()
        nameActorLabelConstraints()
    }
}

// MARK: - Extension + ActorsCollectionViewCell

extension ActorsCollectionViewCell {
    private func actorAvatarConstraints() {
        actorAvatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        actorAvatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        actorAvatarImageView.widthAnchor.constraint(equalToConstant: 46).isActive = true
        actorAvatarImageView.heightAnchor.constraint(equalToConstant: 72).isActive = true
    }

    private func nameActorLabelConstraints() {
        nameActorLabel.topAnchor.constraint(equalTo: actorAvatarImageView.bottomAnchor, constant: -25).isActive = true
        nameActorLabel.leadingAnchor.constraint(equalTo: actorAvatarImageView.leadingAnchor).isActive = true
        nameActorLabel.widthAnchor.constraint(equalToConstant: 46).isActive = true
        nameActorLabel.heightAnchor.constraint(equalToConstant: 72).isActive = true
    }
}
