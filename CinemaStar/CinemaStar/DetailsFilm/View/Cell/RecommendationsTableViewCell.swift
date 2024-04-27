// RecommendationsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Детальная ячейка рекомендуемых к просмотру фильмов
final class RecommendationsTableViewCell: UITableViewCell {
    // MARK: - Constants

    enum Constants {
        static var fontInterRegular = "Inter-Regular"
        static var fontInterSemiBold = "Inter-SemiBold"
        static var seeAlsoText = "Смотрите также"
        static let minimumSpacing: CGFloat = 20
    }

    // MARK: - Visual Components

    private var seeAlsoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Constants.fontInterSemiBold, size: 14)
        label.text = Constants.seeAlsoText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Public Properties

    static let identifier = NSStringFromClass(RecommendationsTableViewCell.self)

    // MARK: - Private Properties

    private var detailsFilmDTO: DetailsFilmDTO?
    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        setupConstraints()
        setupCollectionView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview()
        setupConstraints()
        setupCollectionView()
    }

    // MARK: - Public Methods

    func configureCell(with model: DetailsFilmDTO) {
        detailsFilmDTO = model
        collectionView.reloadData()
    }

    // MARK: - Private Methods

    private func addSubview() {
        contentView.addSubview(seeAlsoLabel)
        contentView.addSubview(collectionView)
    }

    private func setupConstraints() {
        seeAlsoConstraints()
        collectionViewConstraints()
    }

    private func setupCollectionView() {
        layout.scrollDirection = .horizontal
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            RecommendedMoviesCollectionViewCell.self,
            forCellWithReuseIdentifier: RecommendedMoviesCollectionViewCell.identifier
        )
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - Extension + Constraints

extension RecommendationsTableViewCell {
    private func seeAlsoConstraints() {
        seeAlsoLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        seeAlsoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22).isActive = true
        seeAlsoLabel.widthAnchor.constraint(equalToConstant: 117).isActive = true
        seeAlsoLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func collectionViewConstraints() {
        collectionView.topAnchor.constraint(equalTo: seeAlsoLabel.bottomAnchor, constant: -10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 270).isActive = true
    }
}

// MARK: - Extension + UICollectionViewDataSource

extension RecommendationsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        detailsFilmDTO?.similarMovies?.count ?? 2
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecommendedMoviesCollectionViewCell.identifier,
            for: indexPath
        ) as? RecommendedMoviesCollectionViewCell else { return UICollectionViewCell() }
        if let similarMovies = detailsFilmDTO?.similarMovies?[indexPath.item] {
            cell.configureCell(with: similarMovies)
        }
        cell.backgroundColor = .clear
        return cell
    }
}

// MARK: - Extension + UICollectionViewDelegateFlowLayout

extension RecommendationsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (collectionView.frame.width - Constants.minimumSpacing) / 2
        return CGSize(width: width, height: collectionView.frame.height)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        Constants.minimumSpacing
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        Constants.minimumSpacing
    }
}
