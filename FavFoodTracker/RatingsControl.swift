//
//  RatingsControl.swift
//  FavFoodTracker
//
//  Created by SwiftiCode on 4/5/16.
//  Copyright © 2016 SwiftiCode. All rights reserved.
//

import UIKit

class RatingsControl: UIView {

    // MARK: Properties
    var ratings = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var starCollection = [UIButton]()
    let totalStars = 5
    let spacing = 5
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        // Create UIImage with the name of ratings picture
        let emptyStarPic = UIImage(named: "emptyStar")
        let filledStarPic = UIImage(named: "filledStar")
        
        // Make a loop to create each star UIButton
        for _ in 0..<totalStars {
            
            // Create UIButton
            let starButton = UIButton()
            
            // Set Image for UIButton under different state
            starButton.setImage(emptyStarPic, for: UIControlState())
            starButton.setImage(filledStarPic, for: .selected)
            starButton.setImage(filledStarPic, for: [.highlighted, .selected])
            
            // starButton not to adjusted when hightlighted
            starButton.adjustsImageWhenHighlighted = false
            
            // Add the method when UIButton is tap
            starButton.addTarget(self, action: #selector(RatingsControl.starTapped(_:)), for: .touchDown)
            
            // Add to starCollection array
            starCollection += [starButton]
            
            // Add the UIButton as subview
            addSubview(starButton)
        }
    }
    
    override var intrinsicContentSize : CGSize {
        
        // Set the height of the UIButton
        let starSize = Int(frame.size.height)
        // Set the total width of the ratings control
        let totalWidth = totalStars * (starSize + spacing)
        
        return CGSize(width: totalWidth, height: starSize)
    }
    
    override func layoutSubviews() {
        
        let starSize = Int(frame.size.height)
        // Set star frame
        var starFrame = CGRect(x: 0, y: 0, width: starSize, height: starSize)
        
        // For each UIButton, calculate the star point (origin.x)
        for (index, star) in starCollection.enumerated() {
            
            starFrame.origin.x = CGFloat(index * (starSize + spacing))
            star.frame = starFrame
            
        }
        
        updateStarStates()
        
    }
    
    
    // MARK: Actions
    @objc func starTapped(_ star: UIButton) {
        
        ratings = starCollection.index(of: star)! + 1
        
        //print(ratings)
        
        updateStarStates()
        
    }
    
    func updateStarStates() {
        
        for (index, star) in starCollection.enumerated() {
            
            star.isSelected = index < ratings
        }
        
    }

}
