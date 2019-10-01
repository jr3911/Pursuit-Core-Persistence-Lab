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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
