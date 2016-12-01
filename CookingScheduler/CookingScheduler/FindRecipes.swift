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
        let numReplies = 1
        let ingredientsStr = makeString(array: ingredients)
        let urlString = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/findByIngredients?fillIngredients=false&ingredients=\(ingredientsStr)&limitLicense=false&number=5&ranking=1"
        guard let url = NSURL(string: urlString) else {
            print("Error: couldn't create URL from string")
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
                print("Error fetching repositories: \(error)")
                completion(data as NSData?)
                return
            }
            print(response)
            print(data!)
            completion(data as NSData?)
        }
        
        task.resume()
//        var asyncConnection = UNIRest.get({(_ request: UNISimpleRequest) -> Void in
//            request.url = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/findByIngredients?fillIngredients=false&ingredients=\(ingredientsStr)&limitLicense=false&number=5&ranking=1"
//            request.headers = headers
//        }).asJsonAsync({(_ response: UNIHTTPJsonResponse, _ error: Error) -> Void in
//            var code = response.code
//            var responseHeaders = response.headers
//            var body = response.body
//            var rawBody = response.rawBody
//        })
    }
    
    func makeString(array: NSArray) -> NSString {
        return array.componentsJoined(by: "%2C") as NSString
    }
}
