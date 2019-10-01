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
        // Do any additional setup after loading the view.
    }


}

