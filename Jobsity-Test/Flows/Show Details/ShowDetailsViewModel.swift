//
//  ShowDetailsViewModel.swift
//  Jobsity-Test
//
//  Created by Pedro Gomes Rubbo Pacheco on 24/02/22.
//

import Foundation

class ShowDetailsViewModel {
    
    let webService: WebServiceProtocol
    let genres: String
    let name: String
    let imageURL: URL?
    let airsAt: String
    let summary: String
    let showId: Int
    
    var seasons: Box<[Int: [Episode]]>
    
    init(webService: WebService = WebService(), show: Show) {
        self.webService = webService
        self.genres = show.genres.joined(separator: ", ")
        self.name = show.name
        self.imageURL = show.mediumImage
        self.airsAt = "Airs \(show.schedule.days.joined(separator: ", ")) at \(show.schedule.time)"
        self.summary = show.summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        self.showId = show.id
        self.seasons = Box([:])
    }
    
    func fetchSeasons() {
        webService.fetchEpisodes(showId: showId) { result in
            switch result {
            case .success(let episodes):
                self.seasons.value = Dictionary.init(grouping: episodes, by: { episode in
                    return episode.season
                })
            case .failure(_):
                break
            }
        }
    }
    
    func fetchEpisodeViewModel(at indexPath: IndexPath) -> ShowEpisodeCellViewModel {
        return ShowEpisodeCellViewModel(with: seasons.value[indexPath.section + 1, default: []][indexPath.row])
    }
    
    func fetchEpisode(at indexPath: IndexPath) -> Episode {
        return seasons.value[indexPath.section + 1, default: []][indexPath.row]
    }
    
}

class ShowEpisodeCellViewModel {
    
    let episodeCount: String
    let name: String
    
    init(with model: Episode) {
        self.episodeCount = "Episode \(model.number)"
        self.name = model.name
    }
    
}
