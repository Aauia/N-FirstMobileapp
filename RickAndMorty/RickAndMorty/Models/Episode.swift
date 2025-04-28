//
//  Episode.swift
//  RickAndMorty
//
//  Created by Aiaulym Abduohapova on 27.04.2025.
//

import Foundation


struct Episode: Codable, Identifiable {
    let id = UUID()  // Again, Django doesn't give ID, so UUID
    let name: String
    let airDate: String
    let episode: String
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case name
        case airDate = "air_date"
        case episode
        case url
        case created
    }
}
