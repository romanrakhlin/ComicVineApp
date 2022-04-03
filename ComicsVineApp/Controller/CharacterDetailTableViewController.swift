//
//  ComicsDetailsViewController.swift
//  ComicsVineApp
//
//  Created by Roman Rakhlin on 4/1/22.
//

import UIKit

class CharacterDetailTableViewController: UITableViewController {
    
    var character: Character!
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var deckTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setValues()
        styleComponents()
        addNavigationButton()
    }
    
    private func setValues() {
        // setting icon
        ImageDownloader.shared.downloadImage(with: character.image.screenURL, completionHandler: { (image, cached) in
            self.iconImageView.image = image
        }, placeholderImage: UIImage(named: "header"))
        
        // setting other details
        nameLabel.text = character.name
        deckTextView.text = character.deck
    }
    
    //MARK: - Apply shadows on views
    private func styleComponents() {
        outerView.layer.cornerRadius = 12.0
        outerView.layer.shadowColor = UIColor.darkGray.cgColor
        outerView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        outerView.layer.shadowRadius = 4
        outerView.layer.shadowOpacity = 0.4
        
        iconImageView.layer.cornerRadius = 12.0
        iconImageView.clipsToBounds = true
    }
    
    private func addNavigationButton() {
        let saveToFavoritesButton = UIButton(type: .custom)
        saveToFavoritesButton.setImage(UIImage(systemName: "star"), for: .normal)
        saveToFavoritesButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        saveToFavoritesButton.addTarget(self, action: #selector(self.saveToFavorites(_:)), for: .touchUpInside)
        let saveToFavoritesbuttonItem = UIBarButtonItem(customView: saveToFavoritesButton)
        self.navigationItem.rightBarButtonItem = saveToFavoritesbuttonItem
    }
    
    @objc private func saveToFavorites(_ refreshControl: UIRefreshControl) {
        print("Saved!!!!!")
    }
}
