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
        print(info)
        if let id = info["id"] as? Int,
            let title = info["title"] as? String{
            let cookTime = info["readyInMinutes"] as? Int
            let instructions = info["instructions"] as? String
            let cuisines = info["cuisines"] as? [String]
            let ingredientsList = info["extendedIngredients"] as! NSArray
            let url = info["sourceUrl"] as! String ?? "No URL"
            let ingredients = ingredientsList.map({getIngredient(info: $0 as! Dictionary<String, Any>)})
            return RecipeDetails(id:id, title:title, cookTime:cookTime!, instructions: instructions ?? "No Data Available", ingredients:ingredients, cuisines:cuisines!, url:url)
        }
        return nil
    }
    
    func getIngredient(info: Dictionary<String, Any>) -> Ingredient {
        let id = info["id"] as? Int ?? -1
        let name = info["name"] as? String ?? "No Name"
        return Ingredient(id:id, name:name, notes: nil)
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
