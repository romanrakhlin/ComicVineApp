//
//  ComicsCollectionViewController.swift
//  ComicsVineApp
//
//  Created by Roman Rakhlin on 4/1/22.
//

import UIKit

class CharactersCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // ViewModel
    let comicsViewModel = ComicsViewModel()
    
    // Pagination Properties
    var collectionFooterView: LoadingFooterView?
    var isLoading: Bool = false
    var currentOffset = 0
    var currentLimit = 20
    var characters = [Character]()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCharacters()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setUpUI()
    }
    
    // MARK: - Helper Functions
    private func setUpUI() {
        
        // set up collection view
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // style collection view
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width:(self.collectionView.frame.size.width - 10)/2 ,height: (self.collectionView.frame.size.height)/3.5)
        
        // add the reftresh controll
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refreshList(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.black
        collectionView.addSubview(refreshControl)
        
        // hide indicator
        collectionFooterView?.activityIndicaorView.isHidden = true
    }
    
    // get first chunk of characters and set up collection view
    private func fetchCharacters() {
        let internetConnection = comicsViewModel.checkInternerConnection()
        
        if internetConnection {
            showLoader()
            
            comicsViewModel.fetchCharacters(completion: { characters in
                if let characters = characters {
                    DispatchQueue.main.async {
                        self.characters = characters
                        self.collectionView.reloadData()
                        self.hideLoader()
                    }
                }
            }, offset: currentOffset, limit: currentLimit)
        } else {
            showAlert(with: "Error", and: "You have no Internet Connection")
        }
    }
    
    // pagination, preparing next page
    private func getNextPage() {
        let internetConnection = comicsViewModel.checkInternerConnection()
        
        if internetConnection {
            currentOffset = characters.count
            showLoader()
            
            comicsViewModel.fetchCharacters(completion: { characters in
                if let characters = characters {
                    DispatchQueue.main.async {
                        self.characters += characters
                        self.collectionView.reloadData()
                        self.hideLoader()
                    }
                }
            }, offset: currentOffset, limit: currentLimit)
        } else {
            showAlert(with: "Error", and: "You have no Internet Connection")
        }
    }
    
    // for seatching the characters
    private func searchCharacters(with keywords: String) {
        let internetConnection = comicsViewModel.checkInternerConnection()
        
        if internetConnection {
            currentOffset = characters.count
            showLoader()
            
            comicsViewModel.searchCharacters(completion: { characters in
                if let characters = characters {
                    DispatchQueue.main.async {
                        self.characters = characters
                        self.collectionView.reloadData()
                        self.hideLoader()
                    }
                }
            }, keywords: keywords, offset: currentOffset, limit: currentLimit)
        } else {
            showAlert(with: "Error", and: "You have no Internet Connection")
        }
    }
    
    // for showing the loader
    private func showLoader() {
        isLoading = false
        
        collectionFooterView?.activityIndicaorView.isHidden = false
        collectionFooterView?.activityIndicaorView.startAnimating()
    }
    
    // for hiding the loader
    private func hideLoader() {
        isLoading = true
        
        collectionFooterView?.activityIndicaorView.isHidden = true
        collectionFooterView?.activityIndicaorView.stopAnimating()
    }
    
    // pull to refresh action
    @objc private func refreshList(_ refreshControl: UIRefreshControl) {
        collectionView.reloadData()
        currentOffset = 0
        fetchCharacters()
        refreshControl.endRefreshing()
    }
    
    // for desplaying a custom alert
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Delegate
extension CharactersCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "charactersDetail") as! CharacterDetailTableViewController
        
        detailVC.character = self.characters[indexPath.row]
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // loads next page when at the bottom
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentLarger = (scrollView.contentSize.height > scrollView.frame.size.height)
        let viewableHeight = contentLarger ? scrollView.frame.size.height : scrollView.contentSize.height
        let atBottom = (scrollView.contentOffset.y >= scrollView.contentSize.height - viewableHeight + 50)
        
        if atBottom && isLoading {
            getNextPage()
        }
    }
}

// MARK: - Data Source
extension CharactersCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as! CharacterCollectionViewCell
        
        // setting name
        cell.nameLabel.text = characters[indexPath.row].name
        
        // setting icon
        let imageURL = characters[indexPath.row].image.mediumURL
        ImageDownloader.shared.downloadImage(with: imageURL, completionHandler: { (image, cached) in
            cell.iconImageView.image = image
        }, placeholderImage: UIImage(named: "header"))

        return cell
    }
}

// MARK: - Delegate Flow Layout
extension CharactersCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    // for search of Characters
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if kind == UICollectionView.elementKindSectionHeader {
            let headerView:UICollectionReusableView =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "searchView", for: indexPath)
            return headerView
        } else if kind == UICollectionView.elementKindSectionFooter {
            collectionFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "loadingView", for: indexPath) as? LoadingFooterView
            return collectionFooterView!
        }

        // normally should never get here
        return UICollectionReusableView()
    }
}

// MARK: - Search
extension CharactersCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchedText = searchBar.text {
            if searchedText.count >= 4 {
                currentOffset = 0
                characters = []
                searchCharacters(with: searchedText)
            } else if searchedText.count == 0 {
                currentOffset = 0
                fetchCharacters()
            } else {
                self.showAlert(with: "An Error Occured", and: "The name is too short!")
            }
        }
    }
}
