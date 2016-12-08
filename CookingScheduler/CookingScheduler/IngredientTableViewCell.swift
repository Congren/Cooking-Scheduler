//
//  IngredientTableViewCell.swift
//  CookingScheduler
//
//  Created by Travis Chambers on 12/8/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
         self.layoutMargins = .zero
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
