//
//  RecipeDetailsViewController.swift
//  CookingScheduler
//
//  Created by Travis Chambers on 12/1/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import UIKit

protocol GroceryListData {
    func getGroceryList(data: GroceryList)
}

class RecipeDetailsViewController: UIViewController, RecipeDetailProtocol {
    var recipe:Recipe? = nil
    var recipeDetails: RecipeDetails? = nil
    var ingredients:[String] = []
    var groceryList:GroceryList? = nil
    var delegate:GroceryListData? = nil
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UITextView!
    
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
            print(self.recipeDetails?.instructions)
            var temp = ""
            let paragraphs = self.recipeDetails?.instructions
            for s in paragraphs!.characters{
                if temp == ""{
                    temp+=String(s)
                }else if temp.characters.last == " "{
                    if s != " "{
                        temp+=String(s)
                    }
                }else{
                    temp+=String(s)
                }
            }
            self.instructionsLabel.text = temp
        }
        groceryList = GroceryList(ingredientsOwned: ingredients,recipeIngredients: (self.recipeDetails?.ingredients)!)
        let neededIngredients = groceryList?.compareIngredients()
        print(neededIngredients ?? "Did not work")
//        print(self.recipeDetails?.ingredients ?? "No Ingredients")
//        print(type(of:self.recipeDetails?.instructions))
//        print(self.recipeDetails ?? "No Recipe")
//        print(self.recipeDetails?.instructions ?? "No Instructions")
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "ToGroceryList") {
            let gvc:GroceryViewController = segue.destination as! GroceryViewController
            self.delegate = gvc
            self.delegate?.getGroceryList(data: self.groceryList!)
        }
    }


}
