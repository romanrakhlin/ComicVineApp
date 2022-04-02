//
//  ComicsCollectionViewController.swift
//  ComicsVineApp
//
//  Created by Roman Rakhlin on 4/1/22.
//

import UIKit

class ComicsCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var itemsArray = [UIColor]()
    var loadingView: LoadingCollectionView!
    var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        //Register Item Cell
        let itemCellNib = UINib(nibName: "ComicsCollectionViewCell", bundle: nil)
        self.collectionView.register(itemCellNib, forCellWithReuseIdentifier: "collectionviewitemcellid")

        //Register Loading Reuseable View
        let loadingReusableNib = UINib(nibName: "LoadingCollectionView", bundle: nil)
        collectionView.register(loadingReusableNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "loadingresuableviewid")

        loadData()
    }


    func loadData() {
        isLoading = false
        collectionView.collectionViewLayout.invalidateLayout()
        for _ in 0...40 {
            //Add random color in the array
            itemsArray.append(getRandomColor())
        }
        self.collectionView.reloadData()
    }

    func getRandomColor() -> UIColor {
        //Generate between 0 to 1
        let red: CGFloat = CGFloat(drand48())
        let green: CGFloat = CGFloat(drand48())
        let blue: CGFloat = CGFloat(drand48())

        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }

}

extension ComicsCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewitemcellid", for: indexPath) as! ComicsCollectionViewCell
        cell.imageView.backgroundColor = self.itemsArray[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == itemsArray.count - 10 && !self.isLoading {
            loadMoreData()
        }
    }

    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            let start = itemsArray.count
            let end = start + 16
            DispatchQueue.global().async {
                // fake background loading task
                sleep(2)
                for _ in start...end {
                    self.itemsArray.append(self.getRandomColor())
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.isLoading = false
                }
            }
        }
    }

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.isLoading {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 55)
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "loadingresuableviewid", for: indexPath) as! LoadingCollectionView
            loadingView = aFooterView
            loadingView?.backgroundColor = UIColor.clear
            return aFooterView
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.startAnimating()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.stopAnimating()
        }
    }

}

