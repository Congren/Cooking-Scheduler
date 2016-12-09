//
//  FavoritedTableViewController.swift
//  CookingScheduler
//
//  Created by Travis Chambers on 12/8/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import UIKit
import Foundation
import CoreData

@available(iOS 10.0, *)

class FavoritedTableViewController: UITableViewController {

    let errorMess = ErrorMessage()
    var recipes = [FavoritedRecipes]()
    var ingredients:[String] = []
    var selectedRecipe: Recipe? = nil
    let apiClient = FindRecipe()
    let recipeParser = RecipeParser()
    var delegate:RecipeDetailProtocol? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        self.tableView.reloadData()
        self.tableView.register(UINib(nibName: "FavoritedTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableView.layoutMargins = .zero
        self.tableView.separatorInset = .zero

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            recipes = try context.fetch(FavoritedRecipes.fetchRequest())
        }catch{
            print("oh no")
            self.present(errorMess.createErrorMessage(title: "Fetch Failed", message: "Sorry we couldn't retrieve your recipes. Try Again"),animated: true, completion: nil)
        }
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.recipes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoritedTableViewCell
        let recipe = self.recipes[indexPath.row]
        cell.nameLabel?.text = recipe.name

        // Configure the cell...

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let r = self.recipes[indexPath.row]
        self.selectedRecipe = Recipe(id:Int(r.id), title:r.name!, missedIngredients:0, likes:0, imageUrl:r.imageUrl!)
        print("------------\(r.ingredients)--------------")
        //self.ingredients = (r.ingredients?.components(separatedBy: ","))!
        self.performSegue(withIdentifier: "DetailFromFav", sender: self)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
     struct Recipe {
     let id: Int
     let title: String
     let missedIngredients: Int
     let likes: Int
     let imageUrl: String
     }

    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "DetailFromFav") {
            let rdvc:RecipeDetailsViewController = segue.destination as! RecipeDetailsViewController
            rdvc.recipe = self.selectedRecipe
            self.delegate = rdvc
            rdvc.ingredients = self.ingredients
            print("====================")
            print(self.ingredients)
            print("====================")
            apiClient.getRecipeDetails(id: (self.selectedRecipe?.id)!) { (data) in
                rdvc.recipeDetails = self.recipeParser.parseDetails(data: data)
                if (self.delegate != nil) {
                    print(rdvc.recipeDetails)
                    print("askfjl;dksafkasfkdfksfkadskfjlskfjl;akdfkajds")
                    self.delegate!.setRecipeDetails(details: rdvc.recipeDetails!)
                }
            }

        }
    }


}
