//
//  TodoItem+CoreDataProperties.swift
//  
//
//  Created by Andrew Halls on 12/8/17.
//
//

import Foundation
import CoreData


extension TodoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoItem> {
        return NSFetchRequest<TodoItem>(entityName: "TodoItem")
    }

    @NSManaged public var completed: Bool
    @NSManaged public var title: String?

}
