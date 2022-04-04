//
//  ComicsDetailsViewController.swift
//  ComicsVineApp
//
//  Created by Roman Rakhlin on 4/1/22.
//

import UIKit
import CoreData

class CharacterDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var favoritesButton: UIBarButtonItem!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var deckTextView: UITextView!
    
    var character: Character!
    private var addedToFavorites = false
    
    // for core data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setValues()
        styleComponents()
        fetchFavoritesAndCheck()
    }
    
    // MARK: - Helper Functions
    private func setValues() {
        // setting icon
        ImageDownloader.shared.downloadImage(with: character.image.screenURL, completionHandler: { (image, cached) in
            self.iconImageView.image = image
        }, placeholderImage: UIImage(named: "header"))
        
        // setting other details
        nameLabel.text = character.name
        deckTextView.text = character.deck
        
        // set image of navigaton button
        favoritesButton.image = UIImage(systemName: "star")
    }
    
    private func styleComponents() {
        outerView.layer.cornerRadius = 12.0
        outerView.layer.shadowColor = UIColor.darkGray.cgColor
        outerView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        outerView.layer.shadowRadius = 4
        outerView.layer.shadowOpacity = 0.4
        
        iconImageView.layer.cornerRadius = 12.0
        iconImageView.clipsToBounds = true
    }
    
    // Fetch all and check if already added to Favorites
    private func fetchFavoritesAndCheck() {
        let gottenCharacters = try! context.fetch(FavoriteCharacter.fetchRequest())
        
        for character in gottenCharacters {
            if character.name == self.character.name {
                favoritesButton.image = UIImage(systemName: "star.fill")
                addedToFavorites = true
                return
            }
        }
        
        favoritesButton.image = UIImage(systemName: "star")
    }
    
    @IBAction func addToFavoritesButton(_ sender: Any) {
        if !addedToFavorites {
            // add
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let favoriteCharacter = FavoriteCharacter(context: context)
            
            favoriteCharacter.icon = iconImageView.image!.jpegData(compressionQuality: 1.0)
            favoriteCharacter.name = character.name
            favoriteCharacter.deck = character.deck
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            favoritesButton.image = UIImage(systemName: "star.fill")
            addedToFavorites = true
            
            print("Saved")
        } else {
            // remove
            let gottenCharacters = try! context.fetch(FavoriteCharacter.fetchRequest())
            
            for index in 0...gottenCharacters.count {
                if gottenCharacters[index].name == self.character.name {
                    let currentCharacter = gottenCharacters[index]
                    self.context.delete(currentCharacter)
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
                    
                    favoritesButton.image = UIImage(systemName: "star")
                    addedToFavorites = false
                    
                    print("Removed")
                    
                    return
                }
            }
        }
    }
}
