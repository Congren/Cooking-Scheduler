//
//  SavedRecipes+CoreDataProperties.swift
//  
//
//  Created by Andrew Wang on 12/13/16.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension SavedRecipes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedRecipes> {
        return NSFetchRequest<SavedRecipes>(entityName: "SavedRecipes");
    }

    @NSManaged public var id: Int64
    @NSManaged public var ingredientDetail: String?
    @NSManaged public var ingredients: String?
    @NSManaged public var ingredientUnit: String?
    @NSManaged public var name: String?
    @NSManaged public var note: String?
    @NSManaged public var recipe: String?

}
