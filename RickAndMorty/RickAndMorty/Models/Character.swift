//
//  Character.swift
//  RickAndMorty
//
//  Created by Aiaulym Abduohapova on 27.04.2025.
//

import Foundation

// Location model to represent the origin and last known locat

struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: LocationReference
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct Origin: Codable {
    let name: String
    let url: String
}

struct LocationReference: Codable {
    let name: String
    let url: String
}
