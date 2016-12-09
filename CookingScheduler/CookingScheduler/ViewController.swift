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
    var recipesInSections:[[SavedRecipes]] = [[],[],[],[],[],[],[]]
    let days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    let meals = ["Breakfast", "Lunch", "Dinner"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.register(UINib(nibName: "OverviewTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")

    }
    
    override func viewWillAppear(_ animated: Bool){
        //get data from core data
        getData()
        tableView.reloadData()
        //reload table with the data
    }
    
    
    @IBAction func generateList(_ sender: Any) {
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return days[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return recipesInSections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OverviewTableViewCell
        if(indexPath.row < recipesInSections[indexPath.section].count) {
            let recipe = recipesInSections[indexPath.section][indexPath.row]
            cell.titleLabel?.text = recipe.name ?? "No Name"
            cell.mealLabel?.text = meals[Int(recipe.meal) > 0 ? Int(recipe.meal) : 0]
        } else {
            cell.titleLabel?.text = ""
            cell.mealLabel?.text = ""
        }
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
                print(recipes)
                print("====================")
                getSections()
            }
            catch{
                print("Fetching failed")
                self.present(errorMess.createErrorMessage(title: "Fetch Failed", message: "Sorr we couldn't retrieve your recipes. Try Again"),animated: true, completion: nil)
            }
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            recipes = try context.fetch(SavedRecipes.fetchRequest())
            getSections()
        }catch{
            print("oh no")
             self.present(errorMess.createErrorMessage(title: "Fetch Failed", message: "Sorr we couldn't retrieve your recipes. Try Again"),animated: true, completion: nil)
        }
    }
    
    func getSections() {
        recipesInSections = [[],[],[],[],[],[],[]]
        for recipe in recipes {
            let day = Int(recipe.day)
            if(day >= 0 && day <= 7) {
                if(!recipesInSections[day].contains(recipe)) {
                    recipesInSections[day].append(recipe)
                }
            } else {
                if(!recipesInSections[0].contains(recipe)) {
                    recipesInSections[0].append(recipe)
                }
            }
        }
    }
    
}
