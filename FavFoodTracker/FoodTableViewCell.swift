//
//  FoodTableViewCell.swift
//  FavFoodTracker
//
//  Created by SwiftiCode on 4/5/16.
//  Copyright © 2016 SwiftiCode. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var cellFoodNameLabel: UILabel!
    @IBOutlet weak var cellFoodPhotoView: UIImageView!
    @IBOutlet weak var cellFoodRatingsControl: RatingsControl!
    

    // MARK: Default Template
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
