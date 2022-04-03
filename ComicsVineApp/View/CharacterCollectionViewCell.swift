//
//  CharacterCollectionViewCell.swift
//  ComicsVineApp
//
//  Created by Roman Rakhlin on 4/3/22.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageContainter: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        imageContainter.layer.cornerRadius = 12.0
        imageContainter.layer.shadowColor = UIColor.darkGray.cgColor
        imageContainter.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        imageContainter.layer.shadowRadius = 4
        imageContainter.layer.shadowOpacity = 0.4
        
        iconImageView.layer.cornerRadius = 12.0
        iconImageView.clipsToBounds = true
    }
}
