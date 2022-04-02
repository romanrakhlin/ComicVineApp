//
//  LoadingCollectionView.swift
//  ComicsVineApp
//
//  Created by Roman Rakhlin on 4/2/22.
//

import UIKit

class LoadingCollectionView: UICollectionReusableView {

   @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.color = UIColor.white
    }
}
