//
//  RecipeDetailsViewController.swift
//  CookingScheduler
//
//  Created by Travis Chambers on 12/1/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import UIKit
import PTPopupWebView
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
        titleLabel.text = self.recipe?.title
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func viewWebPage(_ sender: Any) {
        let popupvc = PTPopupWebViewController()
        print(self.recipeDetails?.url ?? "No")
        popupvc.popupView.URL(string:(self.recipeDetails?.url)!)
        popupvc.show()
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
        print(neededIngredients ?? "Did not work")
    }
    
    
    @IBAction func saveRecipe(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newRecipe = NSEntityDescription.insertNewObject(forEntityName: "SavedRecipes", into: context)
        newRecipe.setValue(self.recipe?.title, forKey:"name")
        let groceryCurrent = groceryList?.neededIngredients.map({$0.name}).joined(separator:", ")
        newRecipe.setValue(groceryCurrent, forKey:"ingredients")
        newRecipe.setValue(self.recipeDetails?.instructions, forKey:"recipe")
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
