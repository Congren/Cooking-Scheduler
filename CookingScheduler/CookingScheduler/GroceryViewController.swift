//
//  GroceryViewController.swift
//  CookingScheduler
//
//  Created by Travis Chambers on 12/6/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import UIKit

class GroceryViewController: UIViewController {
    @IBOutlet weak var ingredientListLabel: UILabel!
    var groceryList:GroceryList? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientListLabel.text = groceryList?.neededIngredients.map({$0.name}).joined(separator:", ")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
