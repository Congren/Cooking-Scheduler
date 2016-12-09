//
//  IngredientListController.swift
//  CookingScheduler
//
//  Created by Andrew Wang on 12/8/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
class IngredientListController: UIViewController {
    var ingredients = ""
    var recipes: [SavedRecipes] = []
    var ingredientList: [String: [String]] = [:]
    //var ingredientInfos: [String] = []

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            recipes = try context.fetch(SavedRecipes.fetchRequest())
        }
        catch{
            print("error")
        }
        
        for i in recipes{
            if let itemList = i.ingredients{
                if let itemDetails = i.ingredientDetail{
                    if let itemUnits = i.ingredientUnit {
                        let itemArray = itemList.components(separatedBy: ",")
                        let detailArray = itemDetails.components(separatedBy: ",")
                        let unitArray = itemUnits.components(separatedBy: ",")
                        for n in 0..<itemArray.count{
                            if !Array(ingredientList.keys).contains(itemArray[n]){
                                ingredientList[itemArray[n]] = []
                                ingredientList[itemArray[n]] = [detailArray[n], unitArray[n]]
                            }else{
                                if let extra = Double(detailArray[n]) {
                                    let value = Double((ingredientList[itemArray[n]]?[0])!)! + extra
                                    ingredientList[itemArray[n]]![0] = String(value)
                                }
                            }
                        }
                    }
                    //print(ingredientList)
                }
            }
        }
        for pair in ingredientList{
            ingredients += pair.0 + "      ---     " + String(pair.1[0]) + " " + String(pair.1[1]) + "\n"
        }
        print(ingredientList)
        //ingredients += item.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "\n"

        textView.text = ingredients

        // Do any additional setup after loading the view.
    }

    

}
