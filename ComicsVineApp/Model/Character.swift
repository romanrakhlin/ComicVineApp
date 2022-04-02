//
//  Character.swift
//  ComicsVineApp
//
//  Created by Roman Rakhlin on 3/30/22.
//

import Foundation

struct Categories : Codable {
    let id : Int?
    let title : String?
    let photo_count : Int?
    let links : Links?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case photo_count = "photo_count"
        case links = "links"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        photo_count = try values.decodeIfPresent(Int.self, forKey: .photo_count)
        links = try values.decodeIfPresent(Links.self, forKey: .links)
    }

}

struct Links : Codable {
    let _self : String?
    let html : String?
    let download : String?

    enum CodingKeys: String, CodingKey {

        case _self = "self"
        case html = "html"
        case download = "download"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _self = try values.decodeIfPresent(String.self, forKey: ._self)
        html = try values.decodeIfPresent(String.self, forKey: .html)
        download = try values.decodeIfPresent(String.self, forKey: .download)
    }

}

typealias PinModelResponse = [Pin]

struct Pin : Codable {
    let id : String?
    let created_at : String?
    let width : Int?
    let height : Int?
    let color : String?
    let likes : Int?
    let liked_by_user : Bool?
    let user : User?
    let current_user_collections : [String]?
    let urls : Urls?
    let categories : [Categories]?
    let links : Links?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case created_at = "created_at"
        case width = "width"
        case height = "height"
        case color = "color"
        case likes = "likes"
        case liked_by_user = "liked_by_user"
        case user = "user"
        case current_user_collections = "current_user_collections"
        case urls = "urls"
        case categories = "categories"
        case links = "links"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        likes = try values.decodeIfPresent(Int.self, forKey: .likes)
        liked_by_user = try values.decodeIfPresent(Bool.self, forKey: .liked_by_user)
        user = try values.decodeIfPresent(User.self, forKey: .user)
        current_user_collections = try values.decodeIfPresent([String].self, forKey: .current_user_collections)
        urls = try values.decodeIfPresent(Urls.self, forKey: .urls)
        categories = try values.decodeIfPresent([Categories].self, forKey: .categories)
        links = try values.decodeIfPresent(Links.self, forKey: .links)
    }

}

struct Profile_image : Codable {
    let small : String?
    let medium : String?
    let large : String?

    enum CodingKeys: String, CodingKey {

        case small = "small"
        case medium = "medium"
        case large = "large"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        small = try values.decodeIfPresent(String.self, forKey: .small)
        medium = try values.decodeIfPresent(String.self, forKey: .medium)
        large = try values.decodeIfPresent(String.self, forKey: .large)
    }

}


struct Urls : Codable {
    let raw : String?
    let full : String?
    let regular : String?
    let small : String?
    let thumb : String?

    enum CodingKeys: String, CodingKey {

        case raw = "raw"
        case full = "full"
        case regular = "regular"
        case small = "small"
        case thumb = "thumb"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        raw = try values.decodeIfPresent(String.self, forKey: .raw)
        full = try values.decodeIfPresent(String.self, forKey: .full)
        regular = try values.decodeIfPresent(String.self, forKey: .regular)
        small = try values.decodeIfPresent(String.self, forKey: .small)
        thumb = try values.decodeIfPresent(String.self, forKey: .thumb)
    }

}


struct User : Codable {
    let id : String?
    let username : String?
    let name : String?
    let profile_image : Profile_image?
    let links : Links?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case username = "username"
        case name = "name"
        case profile_image = "profile_image"
        case links = "links"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        profile_image = try values.decodeIfPresent(Profile_image.self, forKey: .profile_image)
        links = try values.decodeIfPresent(Links.self, forKey: .links)
    }

}












// MARK: - Character
struct Character: Codable {
    let error: String
    let limit, offset, numberOfPageResults, numberOfTotalResults: Int
    let statusCode: Int
    let results: [Result]
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
struct Result: Codable {
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
