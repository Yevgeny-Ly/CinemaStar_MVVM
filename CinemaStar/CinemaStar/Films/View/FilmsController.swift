// FilmsController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран списка фильмов
final class FilmsController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static var historicalFilmsText = "Смотри исторические \n" +
            "фильмы на CINEMA STAR"
        static var sinemaStarText = "CINEMA STAR"
        static var fontInterRegular = "Inter-Regular"
        static var fontInterSemiBold = "Inter-SemiBold"
        static var topGradientColor = UIColor(named: "topGradientColor")?.cgColor
        static var bottomGradientColor = UIColor(named: "bottomGradientColor")?.cgColor
        static let minimumLineSpacing: CGFloat = 15
        static let widthSizeCell: CGFloat = 170
        static let heightSizeCell: CGFloat = 250
    }

    // MARK: - Visual Components

    private var cinemaStarLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.historicalFilmsText
        label.font = UIFont(name: Constants.fontInterRegular, size: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedString = NSMutableAttributedString(string: Constants.historicalFilmsText)
        attributedString.addAttribute(
            .font,
            value: UIFont(name: Constants.fontInterSemiBold, size: 20) ?? UIFont.systemFont(ofSize: 20),
            range: (Constants.historicalFilmsText as NSString).range(of: Constants.sinemaStarText)
        )
        label.attributedText = attributedString
        return label
    }()

    // MARK: - Private Properties

    private var viewModel: FilmsViewModelProtocol?
    private var filmsNetworkService: [FilmsDTO]?
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    private let layout = UICollectionViewFlowLayout()

    // MARK: - Initializers

    init(viewModel: FilmsViewModelProtocol?) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel?.updateViewHandler = { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(films):
                    self.filmsNetworkService = films
                    self.collectionView.reloadData()
                case .failure, .initial, .loading:
                    break
                }
            }
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        setupConstraints()
        makeGradient()
        setupCollectionView()
        viewModel?.fetchRequestFilms()
    }

    // MARK: - Private Methods

    private func setupCollectionView() {
        collectionView.register(
            FilmsCollectionViewCell.self,
            forCellWithReuseIdentifier: FilmsCollectionViewCell.identifier
        )
        collectionView.backgroundColor = .none
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func addSubview() {
        view.addSubview(cinemaStarLabel)
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        cinemaStarConstraint()
        collectionViewConstraint()
    }

    private func makeGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [Constants.topGradientColor ?? "", Constants.bottomGradientColor ?? UIColor.black.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
    }
}

// MARK: - Extension + Constraints

extension FilmsController {
    private func cinemaStarConstraint() {
        cinemaStarLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 65).isActive = true
        cinemaStarLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        cinemaStarLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func collectionViewConstraint() {
        collectionView.topAnchor.constraint(equalTo: cinemaStarLabel.bottomAnchor, constant: 20).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: - Extension + UICollectionViewDataSource

extension FilmsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filmsNetworkService?.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FilmsCollectionViewCell.identifier,
            for: indexPath
        ) as? FilmsCollectionViewCell else { return UICollectionViewCell() }
        guard let films = filmsNetworkService else { return cell }
        cell.configureCell(with: films[indexPath.item])
        return cell
    }
}

// MARK: - Extension + UICollectionViewDelegate

extension FilmsController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = filmsNetworkService?[indexPath.item].id
        viewModel?.showDetailsFilmViewController(id: id ?? 0)
    }
}

// MARK: - Extension + UICollectionViewDelegateFlowLayout

extension FilmsController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = Constants.widthSizeCell
        let height = Constants.heightSizeCell
        return CGSize(width: width, height: height)
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
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
}
