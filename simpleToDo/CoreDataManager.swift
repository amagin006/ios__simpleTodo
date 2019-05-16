//
//  CoreDataManager.swift
//  simpleToDo
//
//  Created by Shota Iwamoto on 2019-05-15.
//  Copyright © 2019 Shota Iwamoto. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    
    private init(){}
    
    let persistentContainer: NSPersistentContainer = {
       let container = NSPersistentContainer(name: "simpleTodo")
        
        container.loadPersistentStores {(storeDescription, error) in
            if let err = error {
                fatalError("Loading of persistent store failed: \(err)")
            }
        }
        return container
    }()
    
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let saveErr {
                fatalError("failed to changed: \(saveErr)")
            }
        }
    }
    
    
}
