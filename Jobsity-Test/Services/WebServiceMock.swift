//
//  WebServiceMock.swift
//  Jobsity-Test
//
//  Created by Pedro Gomes Rubbo Pacheco on 24/02/22.
//

import Foundation


class WebServiceMock: WebServiceProtocol {

    var shows = [Show]()
    var fetchShowsError: WebServiceError?
    
    func fetchShows(handler: @escaping (Result<[Show], WebServiceError>) -> Void) {
        if let fetchShowsError = fetchShowsError {
            handler(.failure(fetchShowsError))
        } else {
            handler(.success(shows))
        }
    }
    
    func fetchEpisodes(showId: Int, handler: @escaping (Result<[Episode], WebServiceError>) -> Void) {
        handler(.success([]))
    }
    
    
}
