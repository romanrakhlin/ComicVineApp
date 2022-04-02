//
//  ViewController.swift
//  ComicsVineApp
//
//  Created by Roman Rakhlin on 3/30/22.
//

import UIKit

class ComicsTableViewController: UIViewController {
    
    let comicsViewModel = ComicsViewModel()
    var characters = [Result]()
    var page = 1
    var isLoading = false
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //egister cells
        let loadingTableViewCellNib = UINib(nibName: "LoadingTableViewCell", bundle: nil)
        self.tableView.register(loadingTableViewCellNib, forCellReuseIdentifier: "loadingCell")
        
        let comicsTableViewCellNib = UINib(nibName: "ComicsTableViewCell", bundle: nil)
        self.tableView.register(comicsTableViewCellNib, forCellReuseIdentifier: "comicsCell")
        
        // loading initial data from page 1
        comicsViewModel.fetchCharacters(completion: { result in
            self.characters = result
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }, page: page)
        
        // for tableview
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            DispatchQueue.global().async {
                // Fake background loading task for 2 seconds
                sleep(2)
                
                DispatchQueue.main.async {
                    self.page += 1
                }

                self.comicsViewModel.fetchCharacters(completion: { result in
                    self.characters.append(contentsOf: result)
                }, page: self.page)
                
                // Download more data here
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.isLoading = false
                }
            }
        }
    }
}

extension ComicsTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! ComicsDetailViewController
        
        detailVC.title = characters[indexPath.row].name
        detailVC.iconURL = characters[indexPath.row].image.iconURL
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
            loadMoreData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            //Return the amount of items
            return characters.count
        } else if section == 1 {
            //Return the Loading cell
            return 1
        } else {
            //Return nothing
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

extension ComicsTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "comicsCell", for: indexPath) as! ComicsTableViewCell
            cell.nameLabel.text = characters[indexPath.row].name
            
            let imageURL = characters[indexPath.row].image.iconURL
            comicsViewModel.downloadImage(completion: { result in
                cell.iconImage.image = result
            }, url: imageURL)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as! LoadingTableViewCell
            cell.activityIndicator.startAnimating()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 95
        } else {
            return 40
        }
    }
}
