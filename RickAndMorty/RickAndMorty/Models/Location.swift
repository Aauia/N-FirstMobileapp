//
//  Location.swift
//  RickAndMorty
//
//  Created by Aiaulym Abduohapova on 27.04.2025.
//

import Foundation

struct Location: Identifiable, Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]  // Array of URLs (you might want to fetch this separately)
    let url: String
    let created: String
}
