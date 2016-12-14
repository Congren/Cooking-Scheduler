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
    var recipes: [GroceryListIngredients] = []
    var errorMess = ErrorMessage()

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateList()
        
        // Do any additional setup after loading the view.
    }
    func generateList() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        do{
            recipes = try context.fetch(GroceryListIngredients.fetchRequest())
            generateString()
            
        }
        catch{
            self.present(errorMess.createErrorMessage(title: "Grocery List Failed", message: "Something went wrong. We were unable to create a Grocery List."), animated: true, completion: nil)
        }
        
        textView.text = ingredients
    }
    
    func generateString() {
        for i in recipes{
            ingredients = ingredients + "- \(i.title!) --- \(String(i.details)) \(i.units!) \("\n") \("\t")\(i.notes ?? "No Notes") \("\n")"
        }

    }
    

}
