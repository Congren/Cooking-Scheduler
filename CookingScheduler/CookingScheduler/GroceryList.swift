//
//  GroceryList.swift
//  CookingScheduler
//
//  Created by Travis Chambers on 12/5/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import Foundation

class GroceryList {
    var ingredientsOwned: [String] = []
    var recipeIngredients:[Ingredient] = []
    var neededIngredients:[Ingredient] = []
    init(ingredientsOwned: [String], recipeIngredients: [Ingredient]) {
        self.ingredientsOwned = ingredientsOwned
        self.recipeIngredients = recipeIngredients
        print (recipeIngredients)

    }
    
    func compareIngredients() -> [Ingredient] {
        //Probably not the most elegant
        for (i,word) in recipeIngredients.map({$0.name}).enumerated() {
            for other in ingredientsOwned {
                let pattern = "(?i)\\b\(other)\\b"
                if word.range(of:pattern, options: .regularExpression) == nil {
                    neededIngredients.append(recipeIngredients[i])
                }
            }
        }
        //print("Needed: \(neededIngredients)")
        return neededIngredients
    }
}
