// HeaderTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Детальная заглавная ячейка фильма
final class HeaderTableViewCell: UITableViewCell {
    // MARK: - Constants

    enum Constants {
        static var fontInterRegular = "Inter-Regular"
        static var fontInterSemiBold = "Inter-SemiBold"
        static var watchText = "Смотреть"
        static var valueCornerRadius: CGFloat = 12
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

    private var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Constants.fontInterSemiBold, size: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let starLabel: UILabel = {
        let label = UILabel()
        label.text = "⭐"
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

    private lazy var watchButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = Constants.valueCornerRadius
        button.setTitle(Constants.watchText, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "bottomGradientColor")
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(pushWatch), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Public Properties

    static let identifier = NSStringFromClass(HeaderTableViewCell.self)
    var alert: VoidHandler?

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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

    func configureCell(with model: DetailsFilmDTO, voidHandler: @escaping () -> ()) {
        movieCoverImageView.downloaded(from: model.poster?.url ?? "")
        movieTitleLabel.text = model.name
        ratingMovieLabel.text = String(model.rating)
        alert = voidHandler
    }

    // MARK: - Private Methods

    private func addSubview() {
        contentView.addSubview(movieCoverImageView)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(ratingMovieLabel)
        contentView.addSubview(watchButton)
        contentView.addSubview(starLabel)
    }

    private func setupConstraints() {
        movieCoverConstraints()
        cinemaStarConstraints()
        ratingMovieConstraints()
        watchButtonConstraints()
        starConstraints()
    }

    @objc private func pushWatch() {
        alert?()
    }
}

// MARK: - Extension + Constraints

extension HeaderTableViewCell {
    private func movieCoverConstraints() {
        movieCoverImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        movieCoverImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        movieCoverImageView.widthAnchor.constraint(equalToConstant: 170).isActive = true
        movieCoverImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }

    private func cinemaStarConstraints() {
        movieTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 70).isActive = true
        movieTitleLabel.leadingAnchor.constraint(equalTo: movieCoverImageView.trailingAnchor, constant: 10)
            .isActive = true
        movieTitleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        movieTitleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func starConstraints() {
        starLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 5).isActive = true
        starLabel.leadingAnchor.constraint(equalTo: movieCoverImageView.trailingAnchor, constant: 10).isActive = true
        starLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        starLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func ratingMovieConstraints() {
        ratingMovieLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 5).isActive = true
        ratingMovieLabel.leadingAnchor.constraint(equalTo: starLabel.trailingAnchor, constant: 5)
            .isActive = true
        ratingMovieLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        ratingMovieLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func watchButtonConstraints() {
        watchButton.topAnchor.constraint(equalTo: movieCoverImageView.bottomAnchor, constant: 15).isActive = true
        watchButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        watchButton.widthAnchor.constraint(equalToConstant: 358).isActive = true
        watchButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
}
