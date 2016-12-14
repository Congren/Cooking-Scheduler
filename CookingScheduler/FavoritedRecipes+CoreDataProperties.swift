//
//  FavoritedRecipes+CoreDataProperties.swift
//  
//
//  Created by Andrew Wang on 12/13/16.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension FavoritedRecipes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritedRecipes> {
        return NSFetchRequest<FavoritedRecipes>(entityName: "FavoritedRecipes");
    }

    @NSManaged public var id: Int64
    @NSManaged public var imageUrl: String?
    @NSManaged public var ingredients: String?
    @NSManaged public var name: String?

}
