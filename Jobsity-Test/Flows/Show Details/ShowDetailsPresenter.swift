//
//  ShowDetailsPresenter.swift
//  Jobsity-Test
//
//  Created by Pedro Gomes Rubbo Pacheco on 25/01/22.
//

import UIKit

protocol ShowDetailsPresenterDelegate: AnyObject {
    func showDetailsPresenterDelegate(fetched episodes: [Episode])
}

class ShowDetailsPresenter {
    
    let view: (UIViewController & ShowDetailsPresenterDelegate)?
    
    init(view: (UIViewController & ShowDetailsPresenterDelegate)) {
        self.view = view
    }

    func fetchEpisodes(showId: Int) {
        WebService.get(path: "https://api.tvmaze.com/shows/\(showId)/episodes", type: [Episode].self) {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let episodes):
                    self.view?.showDetailsPresenterDelegate(fetched: episodes)
                case .failure(_):
                    self.view?.presentAlert(message: "Something went wrong when searching for the show episodes")
                }
            }
        }
    }
    
}
