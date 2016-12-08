//
//  OverviewView.swift
//  CookingScheduler
//
//  Created by Andrew Wang on 12/7/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import UIKit
import CoreData
class OverviewView: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var notes: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
