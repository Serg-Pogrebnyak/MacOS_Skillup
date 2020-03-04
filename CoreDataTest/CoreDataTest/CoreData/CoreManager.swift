//
//  CoreManager.swift
//  CoreDataTest
//
//  Created by Sergey Pogrebnyak on 04.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Foundation
import CoreData

class CoreManager {
    static var shared = CoreManager()

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataTest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var coreManagerContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func getAllUsers() -> [User]? {
        do {
            return try self.coreManagerContext.fetch(User.fetchRequest()) as? [User]
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }

    }

//    func getAllItems() -> [Item]? {
//        do {
//            return try self.coreManagerContext.fetch(Item.fetchRequest()) as? [Item]
//        } catch {
//            let nserror = error as NSError
//            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//        }
//
//    }

    // MARK: - Core Data Saving support
    func saveContext () {
        if coreManagerContext.hasChanges {
            do {
                try coreManagerContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
