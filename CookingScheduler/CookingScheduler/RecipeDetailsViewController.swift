//
//  RecipeDetailsViewController.swift
//  CookingScheduler
//
//  Created by Travis Chambers on 12/1/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController, RecipeDetailProtocol {
    var recipe:Recipe? = nil
    var recipeDetails: RecipeDetails? = nil
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = self.recipe?.title
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setRecipeDetails(details: RecipeDetails) {
        DispatchQueue.main.async {
            self.instructionsLabel.text = self.recipeDetails?.instructions
        }
        print(self.recipeDetails?.ingredients ?? "No Ingredients")
        print(self.recipeDetails?.instructions ?? "No Instructions")
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
