// FilmsCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Ячейка наименования фильма
final class FilmsCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants

    enum Constants {
        static var fontInterRegular = "Inter-Regular"
        static var fontInterSemiBold = "Inter-SemiBold"
    }

    // MARK: - Visual Components

    private let movieCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleMovieLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Constants.fontInterRegular, size: 16)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let ratingMovieLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Constants.fontInterRegular, size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let starLabel: UILabel = {
        let label = UILabel()
        label.text = "⭐"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Public Properties

    static let identifier = NSStringFromClass(FilmsCollectionViewCell.self)

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

    func configureCell(with model: FilmsDTO) {
        movieCoverImageView.downloaded(from: model.poster ?? "")
        titleMovieLabel.text = model.name
        ratingMovieLabel.text = String(model.rating)
    }

    // MARK: - Private Methods

    private func addSubview() {
        contentView.addSubview(movieCoverImageView)
        contentView.addSubview(titleMovieLabel)
        contentView.addSubview(ratingMovieLabel)
        contentView.addSubview(starLabel)
    }

    private func setupConstraints() {
        movieCoverConstraint()
        titleMovieConstraint()
        starImageViewConstraint()
        ratingMovieConstraint()
    }
}

// MARK: - Extension + Constraints

extension FilmsCollectionViewCell {
    private func movieCoverConstraint() {
        movieCoverImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        movieCoverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        movieCoverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        movieCoverImageView.widthAnchor.constraint(equalToConstant: 170).isActive = true
        movieCoverImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }

    private func titleMovieConstraint() {
        titleMovieLabel.topAnchor.constraint(equalTo: movieCoverImageView.bottomAnchor, constant: 5).isActive = true
        titleMovieLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        titleMovieLabel.widthAnchor.constraint(equalToConstant: 170).isActive = true
        titleMovieLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func starImageViewConstraint() {
        starLabel.topAnchor.constraint(equalTo: titleMovieLabel.bottomAnchor, constant: 5).isActive = true
        starLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        starLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        starLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func ratingMovieConstraint() {
        ratingMovieLabel.topAnchor.constraint(equalTo: titleMovieLabel.bottomAnchor, constant: 5).isActive = true
        ratingMovieLabel.leadingAnchor.constraint(equalTo: starLabel.trailingAnchor, constant: 10).isActive = true
        ratingMovieLabel.widthAnchor.constraint(equalToConstant: 170).isActive = true
        ratingMovieLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
