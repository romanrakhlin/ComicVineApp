//
//  FavoritesTableViewCell.swift
//  ComicsVineApp
//
//  Created by Roman Rakhlin on 4/4/22.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var outterView: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
       
        iconImage.layer.cornerRadius = 18
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
