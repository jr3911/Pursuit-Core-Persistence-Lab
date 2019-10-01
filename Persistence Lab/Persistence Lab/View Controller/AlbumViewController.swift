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
            filteredPhotoResults = self.photoResults
        }
    }
    
    var filteredPhotoResults: [Photo] = [] {
        didSet {
            photoResultsCollectionView.reloadData()
        }
    }
    
    var searchString = "" {
        didSet {
            if self.searchString.count >= 1 {
                filteredPhotoResults = photoResults.filter { $0.tags.lowercased().contains(self.searchString) }
            } else {
                filteredPhotoResults = photoResults
            }
        }
    }
    
    //MARK: IBOutlets
    @IBOutlet weak var photoResultsCollectionView: UICollectionView!
    @IBOutlet weak var photoSearchBar: UISearchBar!
    
    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        loadPhotos()
    }
    
    //MARK: Custom Functions
    private func configureVC() {
        photoResultsCollectionView.dataSource = self
        photoResultsCollectionView.delegate = self
        photoSearchBar.delegate = self
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

//MARK: DataSource Methods
extension AlbumViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredPhotoResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = photoResultsCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let currentPhoto = filteredPhotoResults[indexPath.row]
        
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

//MARK: Delegate Flow Layout
extension AlbumViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width)
    }
}

//MARK: Delegate Methods
extension AlbumViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchString = searchText.lowercased()
    }
}
