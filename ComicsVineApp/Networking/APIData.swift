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

// https://comicvine.gamespot.com/api/search/?api_key=61209f1700a5b27cea03e49cb4118b1dc1e17837&format=json&sort=name:asc&resources=character&query=%22Master%20of%20kung%20fu
extension APIData: URLData {
    var baseURL: URL {
        return URL(string: "https://comicvine.gamespot.com/api/characters")!
    }

    var path: String {
        switch self {
        case .withPage(let apiKey, let offset, let limit):
            return "?api_key=\(apiKey)&offset=\(offset)&limit=\(limit)&format=json"
        case .withSearch(let apiKey, let keyword, let offset, let limit):
            return "?api_key=\(apiKey)&filter=name:\(keyword)&offset=\(offset)&limit=\(limit)&format=json"
        }
    }
}
