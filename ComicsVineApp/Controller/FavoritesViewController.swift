//
//  FavoritesViewController.swift
//  ComicsVineApp
//
//  Created by Roman Rakhlin on 4/4/22.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    let comicsViewModel = ComicsViewModel()
    var favoriteCharacters = [Character]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "comicsCell", for: indexPath) as! FavoritesTableViewCell
        cell.nameLabel.text = favoriteCharacters[indexPath.row].name
        return cell
    }
}
