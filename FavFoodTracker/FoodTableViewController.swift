//
//  FoodTableViewController.swift
//  FavFoodTracker
//
//  Created by SwiftiCode on 4/5/16.
//  Copyright © 2016 SwiftiCode. All rights reserved.
//

import UIKit

class FoodTableViewController: UITableViewController {

    // MARK: Properties
    var foodCollection = [Food]()
    
    // MARK: Food Sample Helper
    func loadSampleFood() {
        
        let photo1 = UIImage(named: "meal1")!
        let meal1 = Food(foodName: "Caprese Salad", foodPhoto: photo1, foodRatings: 4)!
        
        let photo2 = UIImage(named: "meal2")!
        let meal2 = Food(foodName: "Chicken and Potatoes", foodPhoto: photo2, foodRatings: 5)!
        
        let photo3 = UIImage(named: "meal3")!
        let meal3 = Food(foodName: "Pasta with Meatballs", foodPhoto: photo3, foodRatings: 3)!
        
        foodCollection += [meal1, meal2, meal3]
        
    }
    
    // MARK: Default Template
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        if let gotSavedFood = loadSavedFood() {
            
            foodCollection += gotSavedFood
        } else {
            loadSampleFood()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return foodCollection.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "FoodTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FoodTableViewCell

        // Configure the cell...
        let localFood = foodCollection[indexPath.row]
        cell.cellFoodNameLabel.text = localFood.foodName
        cell.cellFoodPhotoView.image = localFood.foodPhoto
        cell.cellFoodRatingsControl.ratings = localFood.foodRatings
        

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            foodCollection.remove(at: indexPath.row)
            saveFood()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
   

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "EditFood" {
            
            let editFoodViewController = segue.destination as! FoodViewController
            
            if let selectedFoodCell = sender as? UITableViewCell {
                
                let selectedIndexPath = tableView.indexPath(for: selectedFoodCell)!
                let selectedFood = foodCollection[selectedIndexPath.row]
                editFoodViewController.currentFood = selectedFood
            }
            
        } else if segue.identifier == "AddFood" {
            
            //print("Add Food....")
        }
    }
    
    
    @IBAction func unwindToFoodList (_ sender: UIStoryboardSegue) {
        
        if let sourceFoodViewController = sender.source as? FoodViewController, let foodToSave = sourceFoodViewController.currentFood {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                foodCollection[selectedIndexPath.row] = foodToSave
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                
            } else {
            
                // Add new food
                let newIndexPath = IndexPath(row: foodCollection.count, section: 0)
                foodCollection.append(foodToSave)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            }
            
        }
        
        // Save Food
        saveFood()
    }

    // MARK: NSCoding
    func saveFood() {
        
        let isSaveFoodGood = NSKeyedArchiver.archiveRootObject(foodCollection, toFile: Food.ArchiveURL.path)
        if !isSaveFoodGood {
            print("Error saving food....")
        }
    }
    
    func loadSavedFood() -> [Food]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Food.ArchiveURL.path) as? [Food]
    }
}
