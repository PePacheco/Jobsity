//
//  WebService.swift
//  Jobsity-Test
//
//  Created by Pedro Gomes Rubbo Pacheco on 25/01/22.
//

import Foundation
import UIKit

enum WebServiceError: Error {
    case badUrlError
    case parsingJsonError
    case noDataError
}

struct WebService {
    // MARK:- Get
    static func get<T:Codable>(path: String, type: T.Type, handler: @escaping (Result<T, WebServiceError>) -> Void) {
        guard let url = URL(string: path) else { handler(.failure(.badUrlError)); return }
        
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil, let data = data  else { handler(.failure(.noDataError)); return }
            guard let data = try? JSONDecoder().decode(T.self, from: data) else { handler(.failure(.parsingJsonError)); return }
            
            handler(.success(data))
        }
        .resume()
    }
    
    // MARK:- Post
    static func post<T:Codable>(path: String, body: [String: AnyHashable], type: T.Type, handler: @escaping (Result<Bool, WebServiceError>) -> Void) {
        guard let url = URL(string: path) else { handler(.failure(.badUrlError)); return }
        
        guard let body = try? JSONSerialization.data(withJSONObject: body, options: []) else { handler(.failure(.parsingJsonError)); return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = body
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil,
                  let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 201 || httpResponse.statusCode == 200 else
            { handler(.failure(.noDataError)); return }
            
            handler(.success(true))
        }
        .resume()
    }
    
}
