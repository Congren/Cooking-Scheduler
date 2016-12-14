//
//  FindRecipes.swift
//  CookingScheduler
//
//  Created by Travis Chambers on 11/21/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import Foundation

class FindRecipe {
    func getRecipe(ingredients: NSArray, completion: @escaping (NSData?) -> Void){
        let ingredientsStr = makeString(array: ingredients)
        print(ingredientsStr)
        let urlString = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/findByIngredients?fillIngredients=false&ingredients=\(ingredientsStr)&limitLicense=false&number=20&ranking=1"
        guard let url = NSURL(string: urlString) else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url as URL)
        request.addValue("JZm8c9iygvmshumZy5EhXTevJpRmp1T72Rcjsn0dQV3IKsmm1d", forHTTPHeaderField: "X-Mashape-Key")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(data as NSData?)
                return
            }
            print("This data: ")
            print(data!)
            completion(data as NSData?)
        }
        
        task.resume()
    }
    
    func makeString(array: NSArray) -> NSString {
        return array.componentsJoined(by: "%2C") as NSString
    }
    
    func getRecipeDetails(id:Int, completion: @escaping (NSData?) -> Void) {
        let urlStrign = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/\(String(id))/information"
        guard let url = NSURL(string: urlStrign) else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url as URL)
        request.addValue("JZm8c9iygvmshumZy5EhXTevJpRmp1T72Rcjsn0dQV3IKsmm1d", forHTTPHeaderField: "X-Mashape-Key")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(data as NSData?)
                return
            }
            completion(data as NSData?)
        }
        
        task.resume()

        
    }
}
