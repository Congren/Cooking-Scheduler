//
//  GroceryList.swift
//  CookingScheduler
//
//  Created by Travis Chambers on 12/5/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.

//  Not implemented

import Foundation

class GroceryList {
    var ingredientsOwned: [String] = []
    var recipeIngredients:[Ingredient] = []
    var neededIngredients:[Ingredient] = []
    var tempIngredients: [Int] = []
    init(ingredientsOwned: [String], recipeIngredients: [Ingredient]) {
        self.ingredientsOwned = ingredientsOwned
        self.recipeIngredients = recipeIngredients
        
    }
    
    func compareIngredients() -> [Ingredient] {
        //Probably not the most elegant
        for (i,word) in recipeIngredients.map({$0.name}).enumerated() {
            if !ingredientsOwned.contains(word) {
//                let pattern = "(?i)\\b\(other)\\b"
//                if word.range(of:pattern, options: .regularExpression) == nil {
                if !tempIngredients.contains(i){
                    tempIngredients.append(i)
                }
            }
        }
        for n in tempIngredients{
            neededIngredients.append(recipeIngredients[n])
        }
        //        print("Needed: \(neededIngredients)")
        return neededIngredients
    }
}
