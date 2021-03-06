//
//  CoreDataManager.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 11/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import CoreData

protocol PersistableObject: NSManagedObject { }

extension PersistableObject {
    static var entityName: String {
        return "\(Self.self)"
    }
}

class CoreDataManager {
    // MARK: - Core Data stack
    static let shared = CoreDataManager()
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoriteMovie")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
    
    func fetch<T: PersistableObject>(predicate: NSPredicate? = nil) -> [T] {
        do{
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: T.entityName)
            request.predicate = predicate
            let result = try persistentContainer.viewContext.fetch(request) as? [T]
            return result ?? []
        } catch{
            print(error)
            return []
        }
    }
    
    func fetchBy<T: PersistableObject>(id: Int) -> T? {
           let predicate = NSPredicate(format: "(id == %d)", id)
        let favMovie: [T] = CoreDataManager.shared.fetch(predicate: predicate)
           return favMovie.first
    }
    
    func isSaved<T: PersistableObject>(entityType: T.Type, id: Int) -> Bool {
        let item: T? = fetchBy(id: id)
        return item != nil
    }
    
    func delete<T: PersistableObject>(entityType: T.Type, predicate: NSPredicate? = nil) {
        do{
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: T.entityName)
            request.predicate = predicate
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            try persistentContainer.viewContext.execute(deleteRequest)
            try persistentContainer.viewContext.save()
        } catch{
            print(error)
            
        }
    }
   
    func deleteBy<T: PersistableObject>(id: Int, entityType: T.Type) {
        let predicate = NSPredicate(format: "(id == %d)", id)
        delete(entityType: T.self, predicate: predicate)
    }
   
    // MARK: - Core Data Saving support
    func saveContext () {
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
