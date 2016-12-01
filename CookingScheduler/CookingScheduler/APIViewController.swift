//
//  APIViewController.swift
//  CookingScheduler
//
//  Created by Travis Chambers on 11/21/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import UIKit

protocol DataFromAPI {
    func dataReceived(data:NSArray)
}

class APIViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var ingredientField: UITextField!
    var delegate:DataFromAPI? = nil
    var ingredients: [String] = []
    let apiClient = FindRecipe()
    let recipeParser = RecipeParser()
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func makeCall(_ sender: Any) {
        apiClient.getRecipe(ingredients: ingredients as NSArray) { (data) in
            let json = self.recipeParser.parseDictionary(data: data)
            print("json: ")
            print(json ?? "Did not work")
            print(self.delegate)
            if (self.delegate != nil) {
                
                self.delegate!.dataReceived(data: json!)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ingredients.append(textField.text!)
        textField.text = ""
        print(ingredients)
        return true
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "RecipeTableViewSegue") {
            let rtv:RecipesTableViewController = segue.destination as! RecipesTableViewController
            
            self.delegate = rtv
        }
    }

}