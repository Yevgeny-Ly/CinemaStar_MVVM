// RecommendedMoviesCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка коллекции рекомендованных фильмов
final class RecommendedMoviesCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants

    enum Constants {
        static var fontInterRegular = "Inter-Regular"
        static var fontInterSemiBold = "Inter-SemiBold"
    }

    // MARK: - Visual Components

    private let movieRecommendationsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Constants.fontInterRegular, size: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Public Properties

    static let identifier = NSStringFromClass(RecommendedMoviesCollectionViewCell.self)

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

    func configureCell(with model: SimilarMovie) {
        movieRecommendationsImageView.downloaded(from: model.poster.url ?? "")
        movieTitleLabel.text = model.name
    }

    // MARK: - Private Methods

    private func addSubview() {
        contentView.addSubview(movieRecommendationsImageView)
        contentView.addSubview(movieTitleLabel)
    }

    private func setupConstraints() {
        movieRecommendationsConstraints()
        movieTitleConstraints()
    }
}

// MARK: - Extension + Constraints

extension RecommendedMoviesCollectionViewCell {
    private func movieRecommendationsConstraints() {
        movieRecommendationsImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20)
            .isActive = true
        movieRecommendationsImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        movieRecommendationsImageView.widthAnchor.constraint(equalToConstant: 170).isActive = true
        movieRecommendationsImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }

    private func movieTitleConstraints() {
        movieTitleLabel.topAnchor.constraint(equalTo: movieRecommendationsImageView.bottomAnchor, constant: 5)
            .isActive = true
        movieTitleLabel.leadingAnchor.constraint(equalTo: movieRecommendationsImageView.leadingAnchor).isActive = true
        movieTitleLabel.widthAnchor.constraint(equalToConstant: 170).isActive = true
        movieTitleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
