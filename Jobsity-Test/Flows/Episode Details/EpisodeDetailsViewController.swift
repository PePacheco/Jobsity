//
//  EpisodeDetailsViewController.swift
//  Jobsity-Test
//
//  Created by Pedro Gomes Rubbo Pacheco on 26/01/22.
//

import UIKit

class EpisodeDetailsViewController: UIViewController, Coordinating {

    var coordinator: Coordinator?
    private var episode: Episode?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    func setEpisode(episode: Episode) {
        self.episode = episode
    }

}
