//
//  CoreDataManager.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 11/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import CoreData

class CoreDataManager {
    // MARK: - Core Data stack
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoriteMovies")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    static func fetch<T>(_ request: NSFetchRequest<T>) -> [T]{
        do{
            let result = try persistentContainer.viewContext.fetch(request)
            return result
        } catch{
            print(error)
            return [T]()
        }
    }
    
    // MARK: - Core Data Saving support
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
