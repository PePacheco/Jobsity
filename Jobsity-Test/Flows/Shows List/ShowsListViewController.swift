//
//  ShowsListViewController.swift
//  Jobsity-Test
//
//  Created by Pedro Gomes Rubbo Pacheco on 25/01/22.
//

import UIKit

class ShowsListViewController: UIViewController, Coordinating {
    
    // MARK: - Outlets
    @IBOutlet weak var seriesTableView: UITableView!
    
    private let searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search..."
        return searchController
    }()
    
    var coordinator: Coordinator?
    private let viewModel = ShowsListViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shows"
        navigationController?.navigationBar.prefersLargeTitles = true
        bindViewModel()
        
        seriesTableView.dataSource = self
        seriesTableView.delegate = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (searchController.searchBar.text ?? "").isEmpty  {
            viewModel.fetchShows()
        }
    }
    
    private func bindViewModel() {
        viewModel.isLoading.bind {[weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    self?.presentLoadingScreen(completion: nil)
                } else {
                    self?.dismiss(animated: true, completion: nil)
                }
            }
        }
        
        viewModel.filteredShows.bind { [weak self] shows in
            DispatchQueue.main.async {
                self?.seriesTableView.reloadData()
            }
        }
    }
    
}

extension ShowsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterShows(query: searchText)
    }
}

extension ShowsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredShows.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "showsListCell", for: indexPath) as? ShowsListTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        let cellViewModel = viewModel.fetchCellViewModel(at: indexPath)
        cell.configure(name: cellViewModel.name, genres: cellViewModel.genres, imageURL: cellViewModel.imageURL, isFavorite: cellViewModel.isFavorite)
        return cell
    }
    
}

extension ShowsListViewController: ShowsListTableViewCellDelegate {
    func showsListTableViewCell(detail cell: UITableViewCell) {
        guard let indexPath = seriesTableView.indexPath(for: cell) else { return }
        let show = viewModel.fetchShow(at: indexPath)
        coordinator?.eventOccurred(with: .goToSeasonDetails(show: show))
    }
    
    func showsListTableViewCell(favorite cell: UITableViewCell) {
        guard let indexPath = seriesTableView.indexPath(for: cell) else { return }
        viewModel.favoriteShow(indexPath: indexPath)
    }
}
