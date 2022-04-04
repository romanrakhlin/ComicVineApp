//
//  APIData.swift
//  ComicsVineApp
//
//  Created by Roman Rakhlin on 4/3/22.
//

import Foundation

protocol URLData {
    var baseURL: URL { get }
    var path: String { get }
}

enum APIData {
    case withPage(apiKey: String, offset: Int, limit: Int)
    case withSearch(apiKey: String, keyword: String, offset: Int, limit: Int)
}

extension APIData: URLData {
    
    // API url with characters parametr
    var baseURL: URL {
        return URL(string: "https://comicvine.gamespot.com/api/characters")!
    }

    // two variations of the path
    var path: String {
        switch self {
        case .withPage(let apiKey, let offset, let limit):
            return "?api_key=\(apiKey)&offset=\(offset)&limit=\(limit)&format=json"
        case .withSearch(let apiKey, let keyword, let offset, let limit):
            return "?api_key=\(apiKey)&filter=name:\(keyword)&offset=\(offset)&limit=\(limit)&format=json"
        }
    }
}
