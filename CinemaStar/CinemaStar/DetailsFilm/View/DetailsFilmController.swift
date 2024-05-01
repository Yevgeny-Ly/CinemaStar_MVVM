// DetailsFilmController.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Экран деталей фильма
final class DetailsFilmController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static var fontInterRegular = "Inter-Regular"
        static var fontInterSemiBold = "Inter-SemiBold"
        static var functionalityUnderDevelopmentText = "Функционал в разработке :("
        static var favoritesIconImageName = "favoritesIconFalse"
        static var topGradientColor = UIColor(named: "topGradientColor")?.cgColor
        static var bottomGradientColor = UIColor(named: "bottomGradientColor")?.cgColor
    }

    // MARK: - Section

    enum DetailsSection {
        case header, description, crewActors, recommendations
    }

    // MARK: - Public Properties

    var selectedIndexPath: IndexPath?

    // MARK: - Private Properties

    private var detailsAction: [DetailsSection] = [.header, .description, .crewActors, .recommendations]
    private var viewModel: DetailsFilmViewModelProtocol?
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let favoriteButton = UIBarButtonItem()
    private var isFavorite: Bool = false

    // MARK: - Initializers

    init(viewModel: DetailsFilmViewModel?) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel?.updateViewHandler = { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(detailsFilm):
                    viewModel?.detailsFilmDTO = detailsFilm
                    if let favoriteMovieId = viewModel?.favoritesService.loadFavoriteMovie(),
                       favoriteMovieId == viewModel?.detailsFilmDTO?.id
                    {
                        self.isFavorite = true
                    } else {
                        self.isFavorite = false
                    }
                    self.updateFavoriteButtonState()
                    if viewModel?.detailsFilmDTO?.similarMovies == nil {
                        self.detailsAction.removeLast()
                    }
                    self.tableView.reloadData()

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
        setupNavigation()
        setupTableView()
        makeGradient()
        viewModel?.fetchRequestDetailsFilm()
    }

    // MARK: - Private Methods

    private func addSubview() {
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableViewConstraints()
    }

    private func setupNavigation() {
        favoriteButton.style = .plain
        favoriteButton.target = self
        favoriteButton.action = #selector(favoriteButtonTap)
        navigationItem.rightBarButtonItem = favoriteButton
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    private func updateFavoriteButtonState() {
        if isFavorite {
            favoriteButton.image = .favoritesIconTrue
        } else {
            favoriteButton.image = .favoritesIconFalse
        }
    }

    private func setupTableView() {
        tableView.register(
            HeaderTableViewCell.self,
            forCellReuseIdentifier: HeaderTableViewCell.identifier
        )
        tableView.register(
            DescriptionTableViewCell.self,
            forCellReuseIdentifier: DescriptionTableViewCell.identifier
        )
        tableView.register(
            CrewActorsTableViewCell.self,
            forCellReuseIdentifier: CrewActorsTableViewCell.identifier
        )
        tableView.register(
            RecommendationsTableViewCell.self,
            forCellReuseIdentifier: RecommendationsTableViewCell.identifier
        )

        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
    }

    private func onAllert() {
        callAlert(message: Constants.functionalityUnderDevelopmentText)
    }

    private func makeGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [Constants.topGradientColor ?? "", Constants.bottomGradientColor ?? UIColor.black.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
    }

    @objc private func favoriteButtonTap() {
        isFavorite = !isFavorite
        updateFavoriteButtonState()

        if isFavorite {
            viewModel?.favoritesService.saveFavoriteMovie(movieId: viewModel?.detailsFilmDTO?.id ?? 0)
        } else {
            UserDefaults.standard.set(nil, forKey: "favoriteMovieId")
        }
    }

    @objc private func cellTapped(_ sender: UITapGestureRecognizer) {
        guard let tapIndexPath = tableView.indexPath(for: sender.view as? UITableViewCell ?? UITableViewCell())
        else { return }
        if selectedIndexPath == tapIndexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = tapIndexPath
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

// MARK: - Extension + Constraints

extension DetailsFilmController {
    private func tableViewConstraints() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: - DetailsFilmController + UITableViewDataSource

extension DetailsFilmController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        detailsAction.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = detailsAction[indexPath.section]
        switch section {
        case .header:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: HeaderTableViewCell.identifier,
                for: indexPath
            ) as? HeaderTableViewCell else { return UITableViewCell() }
            guard let detailsFilm = viewModel?.detailsFilmDTO else { return cell }
            cell.configureCell(with: detailsFilm, voidHandler: onAllert)
            cell.backgroundColor = .clear
            return cell
        case .description:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: DescriptionTableViewCell.identifier,
                for: indexPath
            ) as? DescriptionTableViewCell else { return UITableViewCell() }
            guard let detailsFilm = viewModel?.detailsFilmDTO else { return cell }
            cell.configureCell(with: detailsFilm)
            cell.backgroundColor = .clear

            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
            cell.addGestureRecognizer(tapRecognizer)
            return cell
        case .crewActors:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CrewActorsTableViewCell.identifier,
                for: indexPath
            ) as? CrewActorsTableViewCell else { return UITableViewCell() }
            guard let detailsFilm = viewModel?.detailsFilmDTO else { return cell }
            cell.configureCell(with: detailsFilm)
            cell.backgroundColor = .clear
            return cell
        case .recommendations:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RecommendationsTableViewCell.identifier,
                for: indexPath
            ) as? RecommendationsTableViewCell else { return UITableViewCell() }
            guard let detailsFilm = viewModel?.detailsFilmDTO else { return cell }
            cell.configureCell(with: detailsFilm)
            cell.backgroundColor = .clear
            return cell
        }
    }
}

// MARK: - UserProfileViewController + UITableViewDelegate

extension DetailsFilmController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = detailsAction[indexPath.section]
        switch section {
        case .header:
            return 280
        case .description:
            if let selected = selectedIndexPath, selected == indexPath {
                return 350
            } else {
                return 140
            }
        case .crewActors:
            return 200
        case .recommendations:
            return 280
        }
    }
}
