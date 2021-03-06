//: [Previous](@previous)

import Foundation
import CoreData
import ReSwift
@testable import TodoReduxKit


public class TodoItem: NSManagedObject {
    
}

var persistentContainer: NSPersistentContainer = {
    /*
     The persistent container for the application. This implementation
     creates and returns a container, having loaded the store for the
     application to it. This property is optional since there are legitimate
     error conditions that could cause the creation of the store to fail.
     */
    
    print(Bundle.main.description)
    guard let modelUrl = Bundle.main.url(forResource: "TodoRedux", withExtension: "momd"),
       let model = NSManagedObjectModel(contentsOf: modelUrl)
        else { fatalError("Model not found")}
    
    let container = NSPersistentContainer(name: "TodoRedux",
                                          managedObjectModel: model )
    
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            
            /*
             Typical reasons for an error here include:
             * The parent directory does not exist, cannot be created, or disallows writing.
             * The persistent store is not accessible, due to permissions or data protection when the device is locked.
             * The device is out of space.
             * The store could not be migrated to the current model version.
             Check the error message to determine what the actual problem was.
             */
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })
    return container
}()

func save() {
    // 1
    let managedContext =
        persistentContainer.viewContext
    
    // 2
    let entity =
        NSEntityDescription.entity(forEntityName: "TodoItem",
                                   in: managedContext)!
    
    let todoItem = NSManagedObject(entity: entity,
                                 insertInto: managedContext)
    
    // 3
    todoItem.setValue("First item", forKeyPath: "title")
    todoItem.setValue(false, forKeyPath: "completed")
    
    // 4
    do {
        try managedContext.save()
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }

}
save()

