//
//  ShowsListViewModel.swift
//  Jobsity-Test
//
//  Created by Pedro Gomes Rubbo Pacheco on 21/02/22.
//

import Foundation

class ShowsListViewModel {
    
    let webService: WebService
    
    var isLoading: Box<Bool>
    
    var shows: Box<[Show]>
    var filteredShows: Box<[Show]>
    
    init(webService: WebService = WebService()) {
        self.webService = webService
        self.isLoading = Box(false)
        self.shows = Box([])
        self.filteredShows = Box([])
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
                break
            }
        }
    }
    
    func fetchShow(at indexPath: IndexPath) -> Show {
        return filteredShows.value[indexPath.row]
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
