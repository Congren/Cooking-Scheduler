//
//  ViewController.swift
//  CookingScheduler
//
//  Created by Andrew Wang on 11/16/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import UIKit
//import JTAppleCalendar
import CoreData

//extension UIColor {
//    convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0){
//        self.init(
//            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
//            blue: CGFloat(value & 0x0000FF) / 255.0,
//            alpha: alpha
//        )
//    }
//}
//@available(iOS 10.0, *)
//extension ViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
//    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy MM dd"
//        
//        let startDate = formatter.date(from: "2016 02 01")! // You can use date generated from a formatter
//        let endDate = Date()                                // You can also use dates created from this function
//        let parameters = ConfigurationParameters(startDate: startDate,
//                                                 endDate: endDate,
//                                                 numberOfRows: 6,
//                                                 calendar: Calendar.current,
//                                                 generateInDates: .forAllMonths,
//                                                 generateOutDates: .tillEndOfGrid,
//                                                 firstDayOfWeek: .sunday)
//        return parameters
//    }
//    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
//        let myCustomCell = cell as! CellView
//        
//        // Setup Cell text
//        myCustomCell.dayLabel.text = cellState.text
//        
//        // Setup text color
//        if cellState.dateBelongsTo == .thisMonth {
//            myCustomCell.dayLabel.textColor = UIColor(colorWithHexValue: 0xECEAED)
//        } else {
//            myCustomCell.dayLabel.textColor = UIColor(colorWithHexValue: 0x574865)
//        }
//        
//        handleCellSelection(view: cell, cellState: cellState)
//    }
//    
//    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
//        handleCellSelection(view: cell, cellState: cellState)
//    }
//    
//    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
//        handleCellSelection(view: cell, cellState: cellState)
//    }
//    func handleCellSelection(view: JTAppleDayCellView?, cellState: CellState) {
//        guard let myCustomCell = view as? CellView  else {
//            return
//        }
//        if cellState.isSelected {
//            myCustomCell.selectedView.layer.cornerRadius =  25
//            myCustomCell.selectedView.isHidden = false
//        } else {
//            myCustomCell.selectedView.isHidden = true
//        }
//    }
//}
@available(iOS 10.0, *)
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var tableView: UITableView!
    var recipes: [SavedRecipes] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
//        calendarView.dataSource = self
//        calendarView.delegate = self
//        calendarView.registerCellViewXib(file: "CellView")
//        calendarView.cellInset = CGPoint(x: 0, y: 0)
    }
    
    override func viewWillAppear(_ animated: Bool){
        //get data from core data
        getData()
        tableView.reloadData()
        //reload table with the data
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
            }
            
        }
        tableView.reloadData()
    }
    
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            recipes = try context.fetch(SavedRecipes.fetchRequest())
        }catch{
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedRecipes")
//        request.returnsObjectsAsFaults = false
//        do{
//            let results = try context.fetch(request)
//            if results.count > 0 {
//                recipeNames = []
//                recipeInfos = []
//                recipeIngredients = []
//                for result in results as! [NSManagedObject]
//                {
//                    if let recipeName = result.value(forKey: "name") as? String
//                    {
//                        recipeNames.append(recipeName)
//                    }
//                    if let recipeInfo = result.value(forKey: "recipe") as? String
//                    {
//                        recipeInfos.append(recipeInfo)
//                        
//                    }
//                    if let ingredientList = result.value(forKey: "ingredients") as? String
//                    {
//                        recipeIngredients.append(ingredientList)
//                    }
//                }
//            }
//            
//        }
//        catch{
//            print("something happened")
//        }
            print("oh no")
        }
    }

}

