//
//  FavoritedTableViewCell.swift
//  CookingScheduler
//
//  Created by Travis Chambers on 12/8/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import UIKit

class FavoritedTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
