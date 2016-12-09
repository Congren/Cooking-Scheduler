//
//  SaveRecipeViewController.swift
//  CookingScheduler
//
//  Created by Travis Chambers on 12/9/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import UIKit

protocol SavedRecipeDelegate {
    func dismiss()
    func save(day: Int, meal: Int)
}


class SaveRecipeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var mealPicker: UIPickerView!
    let mealPickerData = ["Breakfast", "Lunch", "Dinner"]
    let dayPickerData = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var dayPicked = -1
    var mealPicked = -1
    var pickerComponents = [Array<Any>]()
    var delegate:SavedRecipeDelegate? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        mealPicker.delegate = self
        mealPicker.dataSource = self
        pickerComponents = [mealPickerData, dayPickerData]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(_ sender: Any) {
        self.delegate?.save(day: dayPicked, meal: mealPicked)
        self.delegate?.dismiss()
    }
    @IBAction func cancel(_ sender: Any) {
        self.delegate?.dismiss()
    }
    
    //MARK: - Delegates and data sources
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerComponents[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerComponents[component][row] as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(component == 0) {
            mealPicked = row
        } else {
            dayPicked = row
        }
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
