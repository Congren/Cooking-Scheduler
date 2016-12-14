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
class RecipeDetailsViewController: UIViewController, RecipeDetailProtocol, SavedRecipeDelegate {
    var recipe:Recipe? = nil
    var recipeDetails: RecipeDetails? = nil
    var ingredients:[String] = []
    var groceryList:GroceryList? = nil
    var delegate:GroceryListData? = nil
    var errorMess = ErrorMessage()
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
        groceryList = GroceryList(ingredientsOwned:ingredients,recipeIngredients: (self.recipeDetails?.ingredients)! )
        _ = groceryList?.compareIngredients()
    }
    
    
    @IBAction func favoriteRecipe(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newRecipe = NSEntityDescription.insertNewObject(forEntityName: "FavoritedRecipes", into: context)
        newRecipe.setValue(self.recipe?.id, forKey:"id")
        newRecipe.setValue(self.recipeDetails?.title, forKey: "name")
        newRecipe.setValue(self.recipe?.imageUrl, forKey: "imageUrl")
        let groceryCurrent = groceryList?.neededIngredients.map({$0.name}).joined(separator:", ")
        newRecipe.setValue(groceryCurrent, forKey:"ingredients")
        do{
            try context.save()
            print("SAVED")
            self.present(errorMess.createErrorMessage(title: "Favorited!", message: "You have Favorited this Recipe!"), animated: true, completion: nil)
        }
        catch{
            print("Error")
            self.present(errorMess.createErrorMessage(title: "Favorite Failed", message: "Something went wrong. Please Try Again"), animated: true, completion: nil)
        }
    }
    
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
        self.view.alpha = 1
    }
    
    func save(day: Int, meal: Int) {
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
        newRecipe.setValue(day, forKey: "day")
        newRecipe.setValue(meal, forKey: "meal")
        do{
            try context.save()
            saveGroceryList()
        }
        catch{
            self.present(errorMess.createErrorMessage(title: "Favorite Failed", message: "Something went wrong. Please Try Again"), animated: true, completion: nil)
        }
        
    }
    
    func saveGroceryList() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        for ing in (self.groceryList?.neededIngredients)! {
            let newIngredient = NSEntityDescription.insertNewObject(forEntityName: "GroceryListIngredients", into: context)
            newIngredient.setValue(ing.name, forKey:"title")
            newIngredient.setValue(ing.id, forKey:"id")
            newIngredient.setValue(ing.notes ?? "No Notes", forKey: "notes")
            newIngredient.setValue(ing.ingredientUnits, forKey:"units")
            newIngredient.setValue(ing.ingredientDetails, forKey: "details")
        }
        
        do{
            try context.save()
            self.present(errorMess.createErrorMessage(title: "Saved!", message: "You have Saved this Recipe!"), animated: true, completion: nil)
        }
        catch{
            self.present(errorMess.createErrorMessage(title: "Favorite Failed", message: "Something went wrong. You Have Saved the Recipe but not the Ingredients"), animated: true, completion: nil)
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
        if(segue.identifier == "SavePopUp") {
            let savePopUp:SaveRecipeViewController = segue.destination as! SaveRecipeViewController
            savePopUp.delegate = self
            self.view.alpha = 0.5
        }
    }


}
