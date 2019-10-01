//
//  DetailPhotoViewController.swift
//  Persistence Lab
//
//  Created by Jason Ruan on 9/30/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class DetailPhotoViewController: UIViewController {
    //mARK: Properties
    var photo: Photo!
    
    //MARK: IBOutlets
    @IBOutlet weak var detailPhotoImageView: UIImageView!
    @IBOutlet weak var submitterNameLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    
    //MARK: IBActions
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        do {
            try favoriteTheImage()
        } catch {
            print(error)
        }
    }
    
    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDetailViews()
    }
    
    private func setUpDetailViews() {
        DispatchQueue.main.async {
            ImageHelper.shared.getImage(url: self.photo.webformatURL) { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let webImage):
                    DispatchQueue.main.async {
                        self.detailPhotoImageView.image = webImage
                    }
                }
            }
        }
        
        submitterNameLabel.text = "Submitted by: \(photo.user)"
        tagsLabel.text = "Tags: \(photo.tags)"
    }
    
    private func favoriteTheImage() throws -> () {
        do {
            try FavoritePhotoPersistenceHelper.manager.save(newPhoto: self.photo)
        } catch {
            throw error
        }
    }
}
