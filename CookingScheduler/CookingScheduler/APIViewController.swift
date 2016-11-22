//
//  APIViewController.swift
//  CookingScheduler
//
//  Created by Travis Chambers on 11/21/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import UIKit

class APIViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var ingredientField: UITextField!
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
            print(json ?? "Did not work")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ingredients.append(textField.text!)
        textField.text = ""
        print(ingredients)
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
