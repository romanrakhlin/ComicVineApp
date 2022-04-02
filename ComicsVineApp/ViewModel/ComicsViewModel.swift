//
//  ComicsViewModel.swift
//  ComicsVineApp
//
//  Created by Roman Rakhlin on 3/30/22.
//

import UIKit

struct ComicsViewModel {

    let baseUrl = "https://comicvine.gamespot.com/api/"
//    let apiKey: String = Bundle.main.infoDictionary!["API_KEY"] as! String
    let apiKey: String = "61209f1700a5b27cea03e49cb4118b1dc1e17837"

    func fetchCharacters(completion: @escaping ([Result]) -> (), page: Int) {
        guard let url = URL(string: baseUrl + "characters/?api_key=" + apiKey + "&format=json&offset=\(page)") else {
            print("problem with URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil && data != nil {
                do {
                    let result = try JSONDecoder().decode(Character.self, from: data!)
                    completion(result.results)
                } catch {
                    print("Error decoding JSON")
                    return
                }
            } else {
                print(error!.localizedDescription)
                return
            }
        }

        task.resume()
    }

    func downloadImage(completion: @escaping (UIImage?) -> (), url: String) {
        guard let url = URL(string: url) else {
            print("problem with URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print(error!.localizedDescription)
                completion(nil)
                return
            }

            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")

            DispatchQueue.main.async() {
                completion(UIImage(data: data)!)
            }
        }

        task.resume()
    }
}
