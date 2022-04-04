//
//  FavoritesViewController.swift
//  ComicsVineApp
//
//  Created by Roman Rakhlin on 4/4/22.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let comicsViewModel = ComicsViewModel()
    var favoriteCharacters = [FavoriteCharacter]()
    
    // for core data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        fetchFavoriteCharacters()
    }
    
    // MARK: - Helper Functions
    private func fetchFavoriteCharacters() {
        do {
            favoriteCharacters = try context.fetch(FavoriteCharacter.fetchRequest())
            print(favoriteCharacters)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Couldn't Fetch Data")
        }
    }
}

// MARK: - Data Source
extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoritesTableViewCell
        
        if let goodImageData = favoriteCharacters[indexPath.row].icon {
            cell.iconImageView.image = UIImage(data: goodImageData)
        }
        cell.nameLabel.text = favoriteCharacters[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let character = self.favoriteCharacters[indexPath.row]
        self.context.delete(character)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        self.favoriteCharacters.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
