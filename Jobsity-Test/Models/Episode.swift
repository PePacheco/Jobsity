//
//  Episode.swift
//  Jobsity-Test
//
//  Created by Pedro Gomes Rubbo Pacheco on 25/01/22.
//

import Foundation

// MARK: - Episode
struct Episode: Codable {
    let id: Int
    let name: String
    let season: Int
    let number: Int
    let image: Image
    let summary: String
    
    var mediumImage: URL? {
        return URL(string: self.image.medium)
    }
    
    var originalImage: URL? {
        return URL(string: self.image.original)
    }
}
