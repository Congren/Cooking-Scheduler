//
//  RecipeDetails.swift
//  CookingScheduler
//
//  Created by Travis Chambers on 12/4/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import Foundation

struct RecipeDetails {
    let id: Int
    let title: String
    let cookTime: Int
    let instructions: String
    let ingredients: [Ingredient]
    let cuisines: [String]
}
