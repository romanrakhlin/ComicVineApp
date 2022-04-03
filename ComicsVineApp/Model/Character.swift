//
//  Character.swift
//  ComicsVineApp
//
//  Created by Roman Rakhlin on 3/30/22.
//

import Foundation

// MARK: - Character
struct Result: Codable {
    let error: String
    let limit, offset, numberOfPageResults, numberOfTotalResults: Int
    let statusCode: Int
    let results: [Character]
    let version: String

    enum CodingKeys: String, CodingKey {
        case error, limit, offset
        case numberOfPageResults = "number_of_page_results"
        case numberOfTotalResults = "number_of_total_results"
        case statusCode = "status_code"
        case results, version
    }
}

// MARK: - Result
struct Character: Codable {
    let aliases: String?
    let apiDetailURL: String
    let birth: String?
    let countOfIssueAppearances: Int
    let dateAdded, dateLastUpdated: String
    let deck, resultDescription: String?
    let firstAppearedInIssue: FirstAppearedInIssue
    let gender, id: Int
    let image: Image
    let name: String
    let origin: FirstAppearedInIssue?
    let publisher: FirstAppearedInIssue
    let realName: String?
    let siteDetailURL: String

    enum CodingKeys: String, CodingKey {
        case aliases
        case apiDetailURL = "api_detail_url"
        case birth
        case countOfIssueAppearances = "count_of_issue_appearances"
        case dateAdded = "date_added"
        case dateLastUpdated = "date_last_updated"
        case deck
        case resultDescription = "description"
        case firstAppearedInIssue = "first_appeared_in_issue"
        case gender, id, image, name, origin, publisher
        case realName = "real_name"
        case siteDetailURL = "site_detail_url"
    }
}

// MARK: - FirstAppearedInIssue
struct FirstAppearedInIssue: Codable {
    let apiDetailURL: String
    let id: Int
    let name: String?
    let issueNumber: String?

    enum CodingKeys: String, CodingKey {
        case apiDetailURL = "api_detail_url"
        case id, name
        case issueNumber = "issue_number"
    }
}

// MARK: - Image
struct Image: Codable {
    let iconURL, mediumURL, screenURL, screenLargeURL: String
    let smallURL, superURL, thumbURL, tinyURL: String
    let originalURL: String
    let imageTags: String

    enum CodingKeys: String, CodingKey {
        case iconURL = "icon_url"
        case mediumURL = "medium_url"
        case screenURL = "screen_url"
        case screenLargeURL = "screen_large_url"
        case smallURL = "small_url"
        case superURL = "super_url"
        case thumbURL = "thumb_url"
        case tinyURL = "tiny_url"
        case originalURL = "original_url"
        case imageTags = "image_tags"
    }
}
