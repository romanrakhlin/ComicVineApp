//
//  Character.swift
//  ComicsVineApp
//
//  Created by Roman Rakhlin on 3/30/22.
//

import Foundation

// MARK: - Character
struct Result: Codable {
    let limit: Int
    let offset: Int
    let results: [Character]

    enum CodingKeys: String, CodingKey {
        case limit
        case offset
        case results
    }
}

// MARK: - Result
struct Character: Codable {
    let deck: String?
    let image: Image
    let name: String

    enum CodingKeys: String, CodingKey {
        case deck
        case image
        case name
    }
}

// MARK: - Image
struct Image: Codable {
    let mediumURL: String
    let screenURL: String

    enum CodingKeys: String, CodingKey {
        case mediumURL = "medium_url"
        case screenURL = "screen_url"
    }
}
