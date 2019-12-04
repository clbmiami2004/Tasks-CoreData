//
//  CoreDataStack.swift
//  Tasks-CoreData
//
//  Created by Lambda_School_Loaner_201 on 12/3/19.
//  Copyright © 2019 Christian Lorenzo. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    
    lazy var container: NSPersistentContainer = {
        let newContainer = NSPersistentContainer(name: "Tasks")
        
        //This is how we get the Database
        newContainer.loadPersistentStores { (_, error) in
            guard error == nil else {
                fatalError("Failed to load persistent stores: \(error!)")
            }
        }
        return newContainer
    }()
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
}
