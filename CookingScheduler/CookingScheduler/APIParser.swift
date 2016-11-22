//
//  APIParser.swift
//  CookingScheduler
//
//  Created by Travis Chambers on 11/21/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import Foundation
typealias JSONDictionary = [String: AnyObject]

class RecipeParser {
    func parseDictionary(data: NSData?) -> NSArray? {
        do {
            print("here")
            let json = try JSONSerialization.jsonObject(with: data as! Data, options: []) as! NSArray
            print(json)
            return json
           
        } catch {
            print("Couldn't parse JSON. Error: \(error)")
        }
        return nil
    }
}
