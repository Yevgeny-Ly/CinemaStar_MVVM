// CrewActorsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Детальная ячейка актеров и съемочной группы фильма
final class CrewActorsTableViewCell: UITableViewCell {
    // MARK: - Constants

    enum Constants {
        static var fontInterRegular = "Inter-Regular"
        static var fontInterSemiBold = "Inter-SemiBold"
        static var castAndCrewText = "Актёры и съемочная группа"
        static var languageText = "Язык"
        static let minimumLineSpacing: CGFloat = 25
    }

    // MARK: - Visual Components

    private var castAndCrewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Constants.fontInterSemiBold, size: 14)
        label.text = Constants.castAndCrewText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var languageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Constants.fontInterSemiBold, size: 14)
        label.text = Constants.languageText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var languageNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.font = UIFont(name: Constants.fontInterSemiBold, size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Public Properties

    static let identifier = NSStringFromClass(CrewActorsTableViewCell.self)

    // MARK: - Private Properties

    private var detailsFilmDTO: DetailsFilmDTO?
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    private let layout = UICollectionViewFlowLayout()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        setupCollectionView()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview()
        setupCollectionView()
        setupConstraints()
    }

    // MARK: - Public Methods

    func configureCell(with model: DetailsFilmDTO) {
        detailsFilmDTO = model
        languageNameLabel.text = model.spokenLanguages?.first?.name
        collectionView.reloadData()
    }

    // MARK: - Private Methods

    private func setupCollectionView() {
        layout.scrollDirection = .horizontal
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            ActorsCollectionViewCell.self,
            forCellWithReuseIdentifier: ActorsCollectionViewCell.identifier
        )
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func addSubview() {
        contentView.addSubview(castAndCrewLabel)
        contentView.addSubview(collectionView)
        contentView.addSubview(languageLabel)
        contentView.addSubview(languageNameLabel)
    }

    private func setupConstraints() {
        castAndCrewConstraints()
        collectionViewConstraints()
        languageConstraints()
        languageNameConstraints()
    }
}

// MARK: - Extension + Constraints

extension CrewActorsTableViewCell {
    private func castAndCrewConstraints() {
        castAndCrewLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        castAndCrewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22).isActive = true
        castAndCrewLabel.widthAnchor.constraint(equalToConstant: 202).isActive = true
        castAndCrewLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func collectionViewConstraints() {
        collectionView.topAnchor.constraint(equalTo: castAndCrewLabel.bottomAnchor, constant: -10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 130).isActive = true
    }

    private func languageConstraints() {
        languageLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -5).isActive = true
        languageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        languageLabel.widthAnchor.constraint(equalToConstant: 36).isActive = true
        languageLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func languageNameConstraints() {
        languageNameLabel.topAnchor.constraint(equalTo: languageLabel.bottomAnchor).isActive = true
        languageNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        languageNameLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        languageNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}

// MARK: - Extension + UICollectionViewDataSource

extension CrewActorsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        detailsFilmDTO?.persons?.count ?? 2
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ActorsCollectionViewCell.identifier,
            for: indexPath
        ) as? ActorsCollectionViewCell else { return UICollectionViewCell() }
        if let actorsMovie = detailsFilmDTO?.persons?[indexPath.item] {
            cell.configureCell(with: actorsMovie)
        }
        cell.backgroundColor = .clear
        return cell
    }
}

// MARK: - Extension + UICollectionViewDelegateFlowLayout

extension CrewActorsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.frame.width / 10
        return CGSize(width: width, height: collectionView.frame.height)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        Constants.minimumLineSpacing
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        Constants.minimumLineSpacing
    }
}
