//
//  ShowDetailsViewController.swift
//  Jobsity-Test
//
//  Created by Pedro Gomes Rubbo Pacheco on 25/01/22.
//

import UIKit
import Kingfisher

class ShowDetailsViewController: UIViewController, Coordinating {
    
    // MARK: - Outlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var airsAtLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var episodesTableView: UITableView!
    
    var coordinator: Coordinator?
    private var viewModel: ShowDetailsViewModel?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.bindViewModel()
        episodesTableView.dataSource = self
        episodesTableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.fetchSeasons()
    }
    
    // MARK: - Functions
    func setShow(show: Show) {
        viewModel = ShowDetailsViewModel(show: show)
    }
    
    func bindViewModel() {
        viewModel?.seasons.bind(listener: {[weak self] _ in
            DispatchQueue.main.async {
                self?.episodesTableView.reloadData()
            }
        })
    }
    
    private func configureUI() {
        posterImageView.kf.setImage(with: viewModel?.imageURL)
        title = viewModel?.name
        genresLabel.text = viewModel?.genres
        airsAtLabel.text = viewModel?.airsAt
        summaryLabel.text = viewModel?.summary
    }

}

extension ShowDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.seasons.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.seasons.value[section + 1, default: []].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Season \(section + 1)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "showEpisodeCell", for: indexPath) as? ShowDetailsTableViewCell,
        let viewModel = viewModel else {
            return UITableViewCell()
        }
        let cellViewModel = viewModel.fetchEpisodeViewModel(at: indexPath)
        cell.configure(name: cellViewModel.name, episodeCount: cellViewModel.episodeCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewModel = viewModel else { return }
        let episode = viewModel.fetchEpisode(at: indexPath)
        coordinator?.eventOccurred(with: .goToEpisodeDetails(episode: episode))
    }
}
