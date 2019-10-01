//
//  ViewController.swift
//  Persistence Lab
//
//  Created by Jason Ruan on 9/30/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {
    //MARK: Properties
    var photoResults: [Photo] = [] {
        didSet {
            photoResultsCollectionView.reloadData()
        }
    }
    
    //MARK: IBOutlets
    @IBOutlet weak var photoResultsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        loadPhotos()
    }
    
    //MARK: Custom Functions
    private func configureCollectionView() {
        photoResultsCollectionView.dataSource = self
        photoResultsCollectionView.delegate = self
    }
    
    private func loadPhotos() {
        PhotosAPIClient.manager.getPhotos { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let arrPhotos):
                self.photoResults = arrPhotos
            }
        }
    }
    
}


}

