//
//  FavoritesViewController.swift
//  ComicsVineApp
//
//  Created by Roman Rakhlin on 4/4/22.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController {
    
    let comicsViewModel = ComicsViewModel()
    var favoriteCharacters = [FavoriteCharacter]()
    
    @IBOutlet weak var tableView: UITableView!
    
    // for core data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        fetchFavoriteCharacters()
    }
    
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

extension FavoritesViewController: UITableViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let detailVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "charactersDetail") as! CharacterDetailTableViewController
//
//        let currentCharacter = favoriteCharacters[indexPath.row]
//
//        // make character
//        let choosenCharacter = Character.init(from: <#T##Decoder#>)
//        choosenCharacter.name = currentCharacter.name!
//        choosenCharacter.image.screenURL = UIImage(data: currentCharacter.icon!)
//        choosenCharacter.deck = currentCharacter.deck
//
//        detailVC.character = self.characters[indexPath.row]
//        self.navigationController?.pushViewController(detailVC, animated: true)
//    }
}
