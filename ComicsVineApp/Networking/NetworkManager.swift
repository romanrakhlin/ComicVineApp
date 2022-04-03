//
//  NetworkManager.swift
//  ComicsVineApp
//
//  Created by Roman Rakhlin on 4/3/22.
//

import Foundation

struct NetworkManager {
    
    // Perform Network Task via URLSession
    func performNetworkTask<T: Codable>(endpoint: APIData, type: T.Type, completion: ((_ response: T) -> Void)?) {
        
        let urlString = endpoint.baseURL.appendingPathComponent(endpoint.path).absoluteString
        print(urlString)
        
        guard let urlRequest = URL(string: urlString ?? "") else {
            print("Some troubles with URL.")
            return
        }
        
        var request = URLRequest(url: urlRequest)
        request.httpMethod = "GET"
        request.addValue("61209f1700a5b27cea03e49cb4118b1dc1e17837", forHTTPHeaderField: "api_key")
        print(request)
        
        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            if let error = error {
                print("An Error occured during the Request.")
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                print("Error recieving data from API.")
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let response = try jsonDecoder.decode(T.self, from: data)
                completion?(response)
            } catch  {
                print("Cannot decode the Response.")
                return
            }
        }
        
        task.resume()
    }
    
}
