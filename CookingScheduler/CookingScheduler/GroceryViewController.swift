//
//  GroceryViewController.swift
//  CookingScheduler
//
//  Created by Travis Chambers on 12/6/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import UIKit

class GroceryViewController: UITableViewController, GroceryListData {

    var groceryList:GroceryList? = GroceryList(ingredientsOwned: [], recipeIngredients: [])
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "GroceryTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
      //  ingredientListLabel.text = groceryList?.neededIngredients.map({$0.name}).joined(separator:", ")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getGroceryList(data: GroceryList) {
        self.groceryList = data
        self.tableView.reloadData()
    }
    
    // MARK: Table View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (groceryList?.neededIngredients.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GroceryTableViewCell
        cell.nameLabel?.text = self.groceryList?.neededIngredients[indexPath.row].name
        return cell
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        performSegueWithIdentifier("toDetailVC", sender: indexPath)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
