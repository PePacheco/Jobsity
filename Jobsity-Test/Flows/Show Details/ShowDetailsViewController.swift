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
    private var show: Show?
    private var presenter: ShowDetailsPresenter?
    private var episodes = [Episode]()
    private var seasons: [Int: [Episode]] = [:]

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = ShowDetailsPresenter(view: self)
        self.configureUI()
        episodesTableView.dataSource = self
        episodesTableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let show = show else { return }
        presenter?.fetchEpisodes(showId: show.id)
    }
    
    // MARK: - Functions
    func setShow(show: Show) {
        self.show = show
    }
    
    private func configureUI() {
        guard let show = show else { return }
        posterImageView.kf.setImage(with: show.mediumImage)
        title = show.name
        genresLabel.text = show.genres.joined(separator: ", ")
        airsAtLabel.text = "Airs \(show.schedule.days.joined(separator: ", ")) at \(show.schedule.time)"
        summaryLabel.text = show.summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }

}

extension ShowDetailsViewController: ShowDetailsPresenterDelegate {
    func showDetailsPresenterDelegate(fetched episodes: [Episode]) {
        self.episodes = episodes
        self.seasons = Dictionary.init(grouping: episodes, by: { episode in
            return episode.season
        })
        DispatchQueue.main.async {
            self.episodesTableView.reloadData()
        }
    }
}

extension ShowDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return seasons.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasons[section + 1, default: []].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Season \(section + 1)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "showEpisodeCell", for: indexPath) as? ShowDetailsTableViewCell else {
            return UITableViewCell()
        }
        let model = seasons[indexPath.section + 1, default: []][indexPath.row]
        cell.configure(name: model.name, episodeCount: "Episode \(model.number)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let episode = seasons[indexPath.section + 1, default: []][indexPath.row]
        coordinator?.eventOccurred(with: .goToEpisodeDetails(episode: episode))
    }
}
