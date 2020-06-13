//
//  Food.swift
//  FavFoodTracker
//
//  Created by SwiftiCode on 4/5/16.
//  Copyright © 2016 SwiftiCode. All rights reserved.
//

import UIKit

class Food: NSObject, NSCoding {
    
    // MARK Properties
    var foodName: String
    var foodPhoto: UIImage
    var foodRatings: Int
    
    // MARK: Type
    struct PropertyKeys {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let ratingsKey = "ratings"
    }
    
    // MARK: ArchiveURL
    static let DocumentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentDirectory.appendingPathComponent("FavFoodTracker")
    
    // MARK: Initialization
    init?(foodName: String, foodPhoto: UIImage, foodRatings: Int) {
        self.foodName = foodName
        self.foodPhoto = foodPhoto
        self.foodRatings = foodRatings
        
        super.init()
        
        if foodName.isEmpty || foodRatings < 0 {
            return nil
        }
        
        if foodRatings > 5 {
            self.foodRatings = 5
        }
    }
    
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(foodName, forKey: PropertyKeys.nameKey)
        aCoder.encode(foodPhoto, forKey: PropertyKeys.photoKey)
        aCoder.encode(foodRatings, forKey: PropertyKeys.ratingsKey)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let localFoodName = aDecoder.decodeObject(forKey: PropertyKeys.nameKey) as! String
        let localFoodPhoto = aDecoder.decodeObject(forKey: PropertyKeys.photoKey) as! UIImage
        let localFoodRatings = aDecoder.decodeInteger(forKey: PropertyKeys.ratingsKey)
        
        self.init(foodName: localFoodName, foodPhoto: localFoodPhoto, foodRatings: localFoodRatings)
        
    }
    
}
