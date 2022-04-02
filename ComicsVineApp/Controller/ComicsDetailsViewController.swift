//
//  ComicsDetailsViewController.swift
//  ComicsVineApp
//
//  Created by Roman Rakhlin on 4/1/22.
//

import UIKit

class ComicsDetailViewController: UIViewController {
    
    let comicsViewModel = ComicsViewModel()
    
    var name: String?
    var iconURL: String?
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        comicsViewModel.downloadImage(completion: { result in
            DispatchQueue.main.async {
                self.iconImageView.image = result
            }
        }, url: iconURL!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
