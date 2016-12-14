//
//  APIParser.swift
//  CookingScheduler
//
//  Created by Travis Chambers on 11/21/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import Foundation


class RecipeParser {
    
    let errorAlert = ErrorMessage()
    
    func parseDictionary(data: NSData?) -> NSArray? {
        do {
            let json = try JSONSerialization.jsonObject(with: data as! Data, options: []) as! NSArray
            let recepieList = json.map({createRecipe(info: $0 as! Dictionary<String, Any>)})
            return recepieList as NSArray?
           
        } catch {
            print("Couldn't parse JSON. Error: \(error)")
        }
        return nil
    }
    
    func parseDetails(data: NSData?) -> RecipeDetails? {
        do {
            let json = try JSONSerialization.jsonObject(with: data as! Data, options: []) as! NSDictionary
            return createRecipeDetails(info: json as! Dictionary<String, Any>)
            
        } catch {
            print("Couldn't parse JSON. Error: \(error)")
        }
        return nil
    }
    
    func createRecipeDetails(info:Dictionary<String, Any>) -> RecipeDetails? {
        if let id = info["id"] as? Int,
            let title = info["title"] as? String{
            let cookTime = info["readyInMinutes"] as? Int
            let instructions = info["instructions"] as? String
            let cuisines = info["cuisines"] as? [String]
            let ingredientsList = info["extendedIngredients"] as! NSArray
            let url = info["spoonacularSourceUrl"] as? String ?? "No URL"
            let ingredients = ingredientsList.map({getIngredient(info: $0 as! Dictionary<String, Any>)})
            return RecipeDetails(id:id, title:title, cookTime:cookTime!, instructions: instructions ?? "No Data Available", ingredients:ingredients as! [Ingredient], cuisines:cuisines! , url:url)
        }
        return nil
    }
    
    func getIngredient(info: Dictionary<String, Any>) -> Ingredient? {
            if let name = info["name"] as? String,
            let ingredientInfo = (info["amount"]! as AnyObject).doubleValue,
            let ingredientUnit = info["unit"] as? String{
                if let id = info["id"] as? Int {
                    return Ingredient(id:id, name:name, notes: nil, ingredientDetails: ingredientInfo, ingredientUnits: ingredientUnit)
                } else {
                    return Ingredient(id:-1, name:name, notes:nil, ingredientDetails: ingredientInfo, ingredientUnits: ingredientUnit)
                }

        } else {
                return Ingredient(id:-1, name:"Error", notes:nil, ingredientDetails: -1, ingredientUnits:"error")
        }
    }
    
    func createRecipe(info:Dictionary<String, Any>) -> Recipe?{
        if let id = info["id"] as? Int,
            let title = info["title"] as? String,
            let likes = info["likes"] as? Int,
            let missedI = info["missedIngredientCount"] as? Int,
            let image = info["image"] as? String{
            
            return Recipe(id:id, title:title, missedIngredients:missedI , likes:likes, imageUrl:image)
        }
        return nil
    }
}
