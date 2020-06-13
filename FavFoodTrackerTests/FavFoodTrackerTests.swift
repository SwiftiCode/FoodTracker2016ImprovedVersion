//
//  FavFoodTrackerTests.swift
//  FavFoodTrackerTests
//
//  Created by SwiftiCode on 4/5/16.
//  Copyright © 2016 SwiftiCode. All rights reserved.
//

import UIKit
import XCTest
@testable import FavFoodTracker

class FavFoodTrackerTests: XCTestCase {
    
    // MARK: FoodTracker Tests
    
    // Tests to confirm that the Meal initializer returns when no name or a negative rating is provided.
    func testMealInitialization() {
        
        let defaultImage = UIImage(named: "defaultPhoto")
        
        // Success case.
        let potentialItem = Food(foodName: "Newest meal", foodPhoto: defaultImage!, foodRatings: 5)
        XCTAssertNotNil(potentialItem)
        
        // Failure cases.
        let noName = Food(foodName: "", foodPhoto: defaultImage!, foodRatings: 0)
        XCTAssertNil(noName, "Empty name is invalid")
        
    }
    
}
