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

//MARK: UICollectionView DataSource Methods
extension AlbumViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = photoResultsCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let currentPhoto = photoResults[indexPath.row]
        
        DispatchQueue.main.async {
            ImageHelper.shared.getImage(url: currentPhoto.previewURL) { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let previewImage):
                    DispatchQueue.main.async {
                        cell.albumPhotoImageView.image = previewImage
                        cell.albumPhotoImageView.contentMode = .scaleAspectFit
                        
                    }
                }
            }
        }
        
        return cell
    }
    
}

