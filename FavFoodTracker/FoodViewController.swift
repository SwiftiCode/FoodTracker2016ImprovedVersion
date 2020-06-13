//
//  FoodViewController.swift
//  FavFoodTracker
//
//  Created by SwiftiCode on 4/5/16.
//  Copyright © 2016 SwiftiCode. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    // MARK: Properties
    @IBOutlet weak var foodNameTextField: UITextField!
    @IBOutlet weak var foodPhotoView: UIImageView!
    @IBOutlet weak var foodRatingsControl: RatingsControl!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // Set a food variable to hold data on this view controller
    var currentFood: Food?
    
    // MARK: Default Template
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        foodNameTextField.delegate = self
        
        if let gotEditFood = currentFood {
            
            self.navigationItem.title = gotEditFood.foodName
            foodNameTextField.text = gotEditFood.foodName
            foodPhotoView.image = gotEditFood.foodPhoto
            foodRatingsControl.ratings = gotEditFood.foodRatings
        }
        
        checkValidName()
    }
    
    
    // MARK: UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        checkValidName()
        self.navigationItem.title = textField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        saveButton.isEnabled = false
    
    }
    
    func checkValidName() {
        
        let nameToCheck = foodNameTextField.text ?? ""
        saveButton.isEnabled = !nameToCheck.isEmpty
    }
    
    
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        // Dismiss view controller when user cancel
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
        foodPhotoView.image = selectedPhoto
        
        dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: Navigation
    @IBAction func cancelFood(_ sender: UIBarButtonItem) {
        
        let isAddFoodMode = presentingViewController is UINavigationController
        
        if isAddFoodMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if saveButton === sender as AnyObject? {
            
            let localFoodName = foodNameTextField.text ?? ""
            let localFoodPhoto = foodPhotoView.image!
            let localFoodRatings = foodRatingsControl.ratings
            
            currentFood = Food(foodName: localFoodName, foodPhoto: localFoodPhoto, foodRatings: localFoodRatings)
        }
    }
    
    // MARK: Actions
    @IBAction func pickFoodPhoto(_ sender: UITapGestureRecognizer) {
        
        // Dismiss any keyboard
        foodNameTextField.resignFirstResponder()
        
        // Create a image picker controller
        let myPhotoPicker = UIImagePickerController()
        
        // Perform basic setup such as source and delegate
        myPhotoPicker.sourceType = .photoLibrary
        myPhotoPicker.delegate = self
        
        // Present view controller
        present(myPhotoPicker, animated: true, completion: nil)
        
    }
    
    


}

