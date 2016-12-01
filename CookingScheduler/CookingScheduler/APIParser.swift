//
//  APIParser.swift
//  CookingScheduler
//
//  Created by Travis Chambers on 11/21/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import Foundation


class RecipeParser {
    func parseDictionary(data: NSData?) -> NSArray? {
        do {
            print("here")
            let json = try JSONSerialization.jsonObject(with: data as! Data, options: []) as! NSArray
            print(json)
            let recepieList = json.map({createRecipe(info: $0 as! Dictionary<String, Any>)})
            return recepieList as NSArray?
           
        } catch {
            print("Couldn't parse JSON. Error: \(error)")
        }
        return nil
    }
    
    func createRecipe(info:Dictionary<String, Any>) -> Recipe?{
        print(info)
        if let id = info["id"] as? Int,
            let title = info["title"] as? String,
            let likes = info["likes"] as? Int,
            let missedI = info["missedIngredientCount"] as? Int {
            
            
            return Recipe(id:id, title:title, missedIngredients:missedI , likes:likes)
        }
        return nil
    }
}
