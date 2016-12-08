//
//  GroceryViewController.swift
//  CookingScheduler
//
//  Created by Travis Chambers on 12/6/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import UIKit

class GroceryViewController: UITableViewController, GroceryListData, NotePopUpDelegate {

    var groceryList:GroceryList? = GroceryList(ingredientsOwned: [], recipeIngredients: [])
    var currentIPath:IndexPath? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "GroceryTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableView.contentInset = UIEdgeInsetsMake(0, -15, 0, 0)
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
    
    func dismissNote() {
        self.dismiss(animated: true, completion: nil)
        self.tableView.alpha = 1
        self.view.backgroundColor = UIColor.white
    }
    
    func submitNote(note: String, indexPath: IndexPath) {
        self.groceryList?.neededIngredients[indexPath.row].notes = note
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
        self.tableView.endUpdates()
    }
    // MARK: Table View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (groceryList?.neededIngredients.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GroceryTableViewCell
        let ingredient = self.groceryList?.neededIngredients[indexPath.row]
        cell.nameLabel?.text = ingredient?.name
        if (ingredient?.notes != nil) {
            cell.notesLabel.text = ingredient?.notes!
            cell.notesLabel.isEnabled = true
        } else {
            cell.notesLabel.isEnabled = false
        }
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.alpha = 0.5
        self.currentIPath = indexPath
        self.performSegue(withIdentifier: "NotePopUp", sender: self)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "NotePopUp") {
            let popUp = segue.destination as! NotePromptViewController
            popUp.delegate = self
            popUp.indexPath = self.currentIPath
        }
    }
 

}
