//
//  ShowsListViewModel.swift
//  Jobsity-Test
//
//  Created by Pedro Gomes Rubbo Pacheco on 21/02/22.
//

import Foundation

class ShowsListViewModel {
    
    let webService: WebServiceProtocol
    
    var isLoading: Box<Bool>
    
    var shows: Box<[Show]>
    var filteredShows: Box<[Show]>
    var error: Box<String>
    
    init(webService: WebServiceProtocol = WebService()) {
        self.webService = webService
        self.isLoading = Box(false)
        self.shows = Box([])
        self.filteredShows = Box([])
        self.error = Box("")
    }
    
    func fetchShows() {
        self.isLoading.value = true
        
        webService.fetchShows {[weak self] result in
            switch result {
            case .success(let shows):
                self?.shows.value = shows
                self?.filteredShows.value = shows
                self?.isLoading.value = false
            case .failure(_):
                self?.error.value = "Something went wrong while fetching the shows"
            }
        }
    }
    
    func fetchShow(at indexPath: IndexPath) -> Show {
        return filteredShows.value[indexPath.row]
    }
    
    func fetchCellViewModel(at indexPath: IndexPath) -> ShowsListCellViewModel {
        return ShowsListCellViewModel(with: fetchShow(at: indexPath))
    }
    
    func filterShows(query: String) {
        filteredShows.value = shows.value
        
        if !query.isEmpty {
            filteredShows.value = shows.value.filter { $0.name.lowercased().contains(query.lowercased())  }
        }
    }
    
    func favoriteShow(indexPath: IndexPath) {
        let show = self.fetchShow(at: indexPath)
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
        filteredShows.fire()
    }
    
}

class ShowsListCellViewModel {
    
    let isFavorite: Bool
    let name: String
    let genres: String
    let imageURL: URL?
    
    init(with model: Show) {
        self.isFavorite = Favorite.all().contains(where: { favorite in
            return favorite.name == model.name
        })
        self.name = model.name
        self.genres = model.genres.joined(separator: ", ")
        self.imageURL = model.mediumImage
    }
    
}
