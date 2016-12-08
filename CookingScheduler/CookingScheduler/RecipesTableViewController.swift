//
//  RecipesTableViewController.swift
//  CookingScheduler
//
//  Created by Travis Chambers on 12/1/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import UIKit
import ImageLoader

typealias JSONDictionary = [String: AnyObject]
protocol RecipeDetailProtocol {
    func setRecipeDetails(details: RecipeDetails)
}

protocol NoRecipesDelegate {
    func displayError()
}

@available(iOS 10.0, *)
class RecipesTableViewController: UITableViewController,DataFromAPI {

    var recipes:[Recipe] = []
    var ingredients:[String] = []
    var selectedRecipe: Recipe? = nil
    let apiClient = FindRecipe()
    let recipeParser = RecipeParser()
    var delegate:RecipeDetailProtocol? = nil
    var noRecipesDelegate:NoRecipesDelegate? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
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

    func dataReceived(data: NSArray) {
        if(data.count == 0) {
            self.navigationController?.popViewController(animated: true)
            self.noRecipesDelegate!.displayError()
        }
        self.recipes = data as! [Recipe]
        print(self.recipes.count)
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.recipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecipeTableViewCell
        let recipe = self.recipes[indexPath.row]
        cell.titleLabel?.text = recipe.title
        cell.likeLabel?.text = String(recipe.likes)
        cell.recipeImage.load(recipe.imageUrl)
        cell.layoutIfNeeded()
        // Configure the cell...
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRecipe = self.recipes[indexPath.row]
        self.performSegue(withIdentifier: "RecipeDetails", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "RecipeDetails") {
            let rdvc:RecipeDetailsViewController = segue.destination as! RecipeDetailsViewController
            rdvc.recipe = self.selectedRecipe
            self.delegate = rdvc
            rdvc.ingredients = self.ingredients
            apiClient.getRecipeDetails(id: (self.selectedRecipe?.id)!) { (data) in
                rdvc.recipeDetails = self.recipeParser.parseDetails(data: data)
                if (self.delegate != nil) {
                    self.delegate!.setRecipeDetails(details: rdvc.recipeDetails!)
                }
            }

        }
    }


}
