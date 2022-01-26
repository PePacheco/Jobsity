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
    private var series = [Serie]()
    private var filteredSeries = [Serie]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Series"
        navigationController?.navigationBar.prefersLargeTitles = true
        presenter = ShowsListPresenter(view: self)
        seriesTableView.dataSource = self
        seriesTableView.delegate = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter?.fetchSeries()
    }
    
}

extension ShowsListViewController: ShowsListPresenterDelegate {
    func showsListPresenterDelegate(fetched series: [Serie]) {
        self.series = series
        self.filteredSeries = series
        seriesTableView.reloadData()
    }
}

extension ShowsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredSeries = series
        
        if !searchText.isEmpty {
            filteredSeries = series.filter { $0.name.lowercased().contains(searchText.lowercased())  }
        }
        seriesTableView.reloadData()
        
    }
}

extension ShowsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSeries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "showsListCell", for: indexPath) as? ShowsListTableViewCell else {
            return UITableViewCell()
        }
        let model = filteredSeries[indexPath.row]
        cell.configure(name: model.name, imageURL: model.mediumImage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(filteredSeries[indexPath.row])
    }
}
