//
//  EpisodeDetailsViewController.swift
//  Jobsity-Test
//
//  Created by Pedro Gomes Rubbo Pacheco on 26/01/22.
//

import UIKit

class EpisodeDetailsViewController: UIViewController, Coordinating {
    
    // MARK: - Outlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    var coordinator: Coordinator?
    private var episode: Episode?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let episode = episode else { return }
        title = episode.name
        configureUI()
    }
    
    // MARK: - Functions
    func setEpisode(episode: Episode) {
        self.episode = episode
    }
    
    private func configureUI() {
        guard let episode = episode else {
            return
        }
        posterImageView.kf.setImage(with: episode.mediumImage)
        episodeNumberLabel.text = "Episode \(episode.number)"
        seasonLabel.text = "Season \(episode.season)"
        summaryLabel.text = episode.summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }

}
