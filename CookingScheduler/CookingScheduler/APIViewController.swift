//
//  APIViewController.swift
//  CookingScheduler
//
//  Created by Travis Chambers on 11/21/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import UIKit

protocol DataFromAPI {
    func dataReceived(data:NSArray)
}

protocol EnteredIngredients {
    func getIngredients(data: NSArray)
}

class APIViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, NoRecipesDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ingredientField: UITextField!
    var delegate:DataFromAPI? = nil
    var iDelegate:EnteredIngredients? = nil
    var ingredients: [String] = []
    let apiClient = FindRecipe()
    let recipeParser = RecipeParser()
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: "IngredientTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableView.layoutMargins = .zero
        self.tableView.separatorInset = .zero
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func makeCall(_ sender: Any) {
        apiClient.getRecipe(ingredients: ingredients as NSArray) { (data) in
            let json = self.recipeParser.parseDictionary(data: data)
            if (self.delegate != nil) {
                self.delegate!.dataReceived(data: json!)
            }
            if(self.iDelegate != nil) {
                self.iDelegate?.getIngredients(data: self.ingredients as NSArray)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ingredients.append(textField.text!)
        textField.text = ""
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [
            IndexPath(row: ingredients.count-1, section: 0)
            ], with: .top)
        self.tableView.endUpdates()
        return true
    }
    
    func displayError() {
        let alert = UIAlertController(title: "No Recipes",
                                      message: "There were no recipes for those ingredients. Please Try Again",
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! IngredientTableViewCell
        let ingredient = ingredients[indexPath.row]
        cell.nameLabel?.text = ingredient
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            ingredients.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "RecipeTableViewSegue") {
            let rtv:RecipesTableViewController = segue.destination as! RecipesTableViewController
            self.delegate = rtv
            rtv.noRecipesDelegate = self
            rtv.ingredients = self.ingredients
        }
    }

}
