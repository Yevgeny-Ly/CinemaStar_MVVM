// DescriptionTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Детальная ячейка описания фильма
final class DescriptionTableViewCell: UITableViewCell {
    // MARK: - Constants

    enum Constants {
        static var fontInterRegular = "Inter-Regular"
        static var fontInterSemiBold = "Inter-SemiBold"
    }

    // MARK: - Visual Components

    private var movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Constants.fontInterRegular, size: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var yearManufactureCountryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.font = UIFont(name: Constants.fontInterRegular, size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var changesHeightCellButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.arrowDown, for: .normal)
        button.tintColor = .white
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Public Properties

    static let identifier = NSStringFromClass(DescriptionTableViewCell.self)

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

    func configureCell(with model: DetailsFilmDTO) {
        movieDescriptionLabel.text = model.description
        yearManufactureCountryLabel.text =
            "\(model.year ?? 0) / \(model.countries?.first?.name ?? "") / \(model.type ?? "")"
    }

    // MARK: - Private Methods

    private func addSubview() {
        contentView.addSubview(movieDescriptionLabel)
        contentView.addSubview(yearManufactureCountryLabel)
        contentView.addSubview(changesHeightCellButton)
    }

    private func setupConstraints() {
        movieDescriptionConstraints()
        yearManufactureCountryConstraints()
        watchButtonConstraints()
    }
}

// MARK: - Extension + Constraints

extension DescriptionTableViewCell {
    private func movieDescriptionConstraints() {
        movieDescriptionLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        movieDescriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        movieDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        movieDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true
        movieDescriptionLabel.widthAnchor.constraint(equalToConstant: 330).isActive = true
        movieDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
    }

    private func yearManufactureCountryConstraints() {
        yearManufactureCountryLabel.topAnchor.constraint(equalTo: movieDescriptionLabel.bottomAnchor)
            .isActive = true
        yearManufactureCountryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22).isActive = true
        yearManufactureCountryLabel.widthAnchor.constraint(equalToConstant: 170).isActive = true
        yearManufactureCountryLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func watchButtonConstraints() {
        changesHeightCellButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        changesHeightCellButton.leadingAnchor.constraint(equalTo: movieDescriptionLabel.trailingAnchor)
            .isActive = true
        changesHeightCellButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        changesHeightCellButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
}
