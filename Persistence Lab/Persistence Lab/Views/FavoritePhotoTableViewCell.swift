//
//  FavoritePhotoTableViewCell.swift
//  Persistence Lab
//
//  Created by Jason Ruan on 9/30/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class FavoritePhotoTableViewCell: UITableViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var favoritePhotoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
