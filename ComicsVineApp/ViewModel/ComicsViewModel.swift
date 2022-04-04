//
//  ComicsViewModel.swift
//  ComicsVineApp
//
//  Created by Roman Rakhlin on 3/30/22.
//

import Foundation

class ComicsViewModel {
    
    let networkManager = NetworkManager()
    
    // cause of a weird response from Info.plist, we replacing "\\" with ""
    let apiKey: String = (Bundle.main.infoDictionary!["API_KEY"] as! String).replacingOccurrences(of: "\"", with: "")
    
    // getting characters from an API with limit and offset
    func fetchCharacters(completion: @escaping ([Character]?) -> (), offset: Int, limit: Int) {
        networkManager.performNetworkTask(endpoint: APIData.withPage(apiKey: apiKey, offset: offset, limit: limit), type: Result.self) { response in
            completion(response.results)
        }
        completion(nil)
    }
    
    // search for characters with specific keywords, also offset and limit
    func searchCharacters(completion: @escaping ([Character]?) -> (), keywords: String, offset: Int, limit: Int) {
        networkManager.performNetworkTask(endpoint: APIData.withSearch(apiKey: apiKey, keyword: keywords, offset: offset, limit: limit), type: Result.self) { response in
            completion(response.results)
        }
        completion(nil)
    }
    
    // for checking the interner connection
    func checkInternerConnection() -> Bool {
        return networkManager.isConnectedToNetwork()
    }
}
