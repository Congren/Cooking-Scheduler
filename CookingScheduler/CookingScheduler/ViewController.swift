//
//  ViewController.swift
//  CookingScheduler
//
//  Created by Andrew Wang on 11/16/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import UIKit
import CoreData
@available(iOS 10.0, *)
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    @IBOutlet weak var tableView: UITableView!
    let errorMess = ErrorMessage()
    var recipes: [SavedRecipes] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool){
        //get data from core data
        getData()
        tableView.reloadData()
        //reload table with the data
    }
    
    
    @IBAction func generateList(_ sender: Any) {
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell()
        let recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe.name!
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete {
            let recipe = recipes[indexPath.row]
            context.delete(recipe)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do{
                recipes = try context.fetch(SavedRecipes.fetchRequest())
            }
            catch{
                print("Fetching failed")
                self.present(errorMess.createErrorMessage(title: "Fetch Failed", message: "Sorr we couldn't retrieve your recipes. Try Again"),animated: true, completion: nil)
            }
        }
        tableView.reloadData()
    }
    
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            recipes = try context.fetch(SavedRecipes.fetchRequest())
        }catch{
            print("oh no")
             self.present(errorMess.createErrorMessage(title: "Fetch Failed", message: "Sorr we couldn't retrieve your recipes. Try Again"),animated: true, completion: nil)
        }
    }
    
}
