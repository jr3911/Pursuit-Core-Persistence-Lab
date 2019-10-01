//
//  FavoritesViewController.swift
//  Persistence Lab
//
//  Created by Jason Ruan on 9/30/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    //MARK: Properties
    var favorites: [Photo] = [] {
        didSet {
            favoritePhotosTableVIew.reloadData()
        }
    }
    
    //MARK: IBOutlets
    @IBOutlet weak var favoritePhotosTableVIew: UITableView!
    
    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFavTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadFavoritePhotos()
    }
    
    //MARK: Custom Functions
    private func loadFavoritePhotos() {
        do {
            self.favorites = try FavoritePhotoPersistenceHelper.manager.getFavoritePhotos()
        } catch {
            print(error)
        }
    }
    
    private func configureFavTableView() {
        favoritePhotosTableVIew.dataSource = self
        favoritePhotosTableVIew.delegate = self
    }

}

//MARK: DataSource Methods
extension FavoritesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Favorite Photos"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritePhotosTableVIew.dequeueReusableCell(withIdentifier: "favoritePhotoCell", for: indexPath) as! FavoritePhotoTableViewCell
        let currentFavPhoto = favorites[indexPath.row]
        
        DispatchQueue.main.async {
            ImageHelper.shared.getImage(url: currentFavPhoto.webformatURL) { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let favImage):
                    DispatchQueue.main.async {
                        cell.favoritePhotoImageView.image = favImage
                    }
                }
            }
        }
        return cell
    }
    
    
}

//MARK: Delegate Methods
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
