//
//  WebService.swift
//  Jobsity-Test
//
//  Created by Pedro Gomes Rubbo Pacheco on 25/01/22.
//

import Foundation
import UIKit

protocol WebServiceProtocol {
    func fetchShows(handler: @escaping (Result<[Show], WebServiceError>) -> Void)
    func fetchEpisodes(showId: Int,handler: @escaping (Result<[Episode], WebServiceError>) -> Void)
}

enum WebServiceError: Error {
    case badUrlError
    case parsingJsonError
    case noDataError
}

struct WebService: WebServiceProtocol {
    
    init() {}
    
    func fetchShows(handler: @escaping (Result<[Show], WebServiceError>) -> Void) {
        guard let url = URL(string: "https://api.tvmaze.com/shows?page=0") else { handler(.failure(.badUrlError)); return }
        
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil, let data = data  else { handler(.failure(.noDataError)); return }
            guard let data = try? JSONDecoder().decode([Show].self, from: data) else { handler(.failure(.parsingJsonError)); return }
            
            handler(.success(data))
        }
        .resume()
    }
    
    func fetchEpisodes(showId: Int,handler: @escaping (Result<[Episode], WebServiceError>) -> Void) {
        guard let url = URL(string: "https://api.tvmaze.com/shows/\(showId)/episodes") else { handler(.failure(.badUrlError)); return }
        
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil, let data = data  else { handler(.failure(.noDataError)); return }
            guard let data = try? JSONDecoder().decode([Episode].self, from: data) else { handler(.failure(.parsingJsonError)); return }
            
            handler(.success(data))
        }
        .resume()
    }
    
}
