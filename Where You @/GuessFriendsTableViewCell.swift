//
//  GuessFriendsTableViewCell.swift
//  Where You @
//
//  Created by Nick Cowart on 3/18/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

import UIKit

class GuessFriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var fBProfilePic: UIImageView!
    
    @IBOutlet weak var friendsName: UILabel!
   
    @IBOutlet weak var timeAndDatePosted: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
                        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
}
