//
//  Serie.swift
//  Jobsity-Test
//
//  Created by Pedro Gomes Rubbo Pacheco on 25/01/22.
//

import Foundation

struct Show: Codable {
    let id: Int
    let url: String
    let name, type, language: String
    let genres: [String]
    let schedule: Schedule
    let image: Image
    let summary: String?

    var mediumImage: URL? {
        return URL(string: self.image.medium)
    }
    
    var originalImage: URL? {
        return URL(string: self.image.original)
    }
}

// MARK: - Image
struct Image: Codable {
    let medium, original: String
}


// MARK: - Schedule
struct Schedule: Codable {
    let time: String
    let days: [String]
}
