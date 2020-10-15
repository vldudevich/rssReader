//
//  CoreDataStack.swift
//  RssReader
//
//  Created by vladislav on 18.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    let entity = NSEntityDescription()
    let object = NSManagedObject()
    let viewcontext = PersistenceService.shared.persistentContainer.viewContext
    
    func saveContext() {
        PersistenceService.shared.saveContext()
    }
    init() {
        
    }
}
