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
    private var presenter: ShowsListPresenter?
    private var shows = [Show]()
    private var filteredShows = [Show]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shows"
        navigationController?.navigationBar.prefersLargeTitles = true
        presenter = ShowsListPresenter(view: self)
        
        seriesTableView.dataSource = self
        seriesTableView.delegate = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (searchController.searchBar.text ?? "").isEmpty  {
            self.presenter?.fetchSeries()
        }
    }
    
}

extension ShowsListViewController: ShowsListPresenterDelegate {
    func showsListPresenterDelegate(fetched shows: [Show]) {
        self.filteredShows = shows
        self.shows = shows
        seriesTableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}

extension ShowsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredShows = shows
        
        if !searchText.isEmpty {
            filteredShows = shows.filter { $0.name.lowercased().contains(searchText.lowercased())  }
        }
        seriesTableView.reloadData()
        
    }
}

extension ShowsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "showsListCell", for: indexPath) as? ShowsListTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        let model = filteredShows[indexPath.row]
        let isFavorite = Favorite.all().contains(where: { favorite in
            return favorite.name == model.name
        })
        cell.configure(name: model.name, genres: model.genres.joined(separator: ", "), imageURL: model.mediumImage, isFavorite: isFavorite)
        return cell
    }
    
}

extension ShowsListViewController: ShowsListTableViewCellDelegate {
    func showsListTableViewCell(detail cell: UITableViewCell) {
        guard let indexPath = seriesTableView.indexPath(for: cell) else { return }
        let show = filteredShows[indexPath.row]
        coordinator?.eventOccurred(with: .goToSeasonDetails(show: show))
    }
    
    func showsListTableViewCell(favorite cell: UITableViewCell) {
        guard let indexPath = seriesTableView.indexPath(for: cell) else { return }
        let show = filteredShows[indexPath.row]
        if !Favorite.all().contains(where: { favorite in
            return favorite.name == show.name
        }) {
            let favorite = Favorite(name: show.name)
            let _ = favorite.save()
        } else {
            guard let favorite = Favorite.all().first(where: { favorite in
                return favorite.name == show.name
            }) else { return }
            let _ = favorite.destroy()
        }
        seriesTableView.reloadData()
    }
}
