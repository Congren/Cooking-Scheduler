//
//  RecipeDetailsViewController.swift
//  CookingScheduler
//
//  Created by Travis Chambers on 12/1/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import UIKit
import CoreData
protocol GroceryListData {
    func getGroceryList(data: GroceryList)
}

@available(iOS 10.0, *)
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
        //print(self.recipeDetails?.ingredients)
        titleLabel.text = self.recipe?.title
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setRecipeDetails(details: RecipeDetails) {
        DispatchQueue.main.async {
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
        groceryList = GroceryList(ingredientsOwned: ingredients,recipeIngredients: (self.recipeDetails?.ingredients)! as! [Ingredient])
        let neededIngredients = groceryList?.compareIngredients()
    //    print(neededIngredients ?? "Did not work")
//        print(self.recipeDetails?.ingredients ?? "No Ingredients")
//        print(type(of:self.recipeDetails?.instructions))
//        print(self.recipeDetails ?? "No Recipe")
//        print(self.recipeDetails?.instructions ?? "No Instructions")
    }
    
    
    @IBAction func saveRecipe(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newRecipe = NSEntityDescription.insertNewObject(forEntityName: "SavedRecipes", into: context)
        newRecipe.setValue(self.recipe?.title, forKey:"name")
        let groceryCurrent = groceryList?.neededIngredients.map({$0.name}).joined(separator:",")
        newRecipe.setValue(groceryCurrent, forKey:"ingredients")
        newRecipe.setValue(self.recipeDetails?.instructions, forKey:"recipe")
        let ingredientDetailInfo = self.recipeDetails?.ingredients.map({String($0.ingredientDetails)}).joined(separator:",")
        let ingredientUnitInfo = self.recipeDetails?.ingredients.map({String($0.ingredientUnits)}).joined(separator:",")
        newRecipe.setValue(ingredientDetailInfo!, forKey:"ingredientDetail")
        newRecipe.setValue(ingredientUnitInfo!, forKey:"ingredientUnit")
        do{
            try context.save()
            print("SAVED")
        }
        catch{
            print("Error")
        }

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
