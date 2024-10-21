//
//  CoreDataManageable.swift
//  JGDDMembership
//
//  Created by minsong kim on 10/21/24.
//

import CoreData
import UIKit

protocol CoreDataManageable {
    var container: NSPersistentContainer { get }
}

extension CoreDataManageable {
    func createCoreData(image: String, name: String, greeting: String, mbti: String) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: "Profile", in: container.viewContext) else {
            throw ModelError.bindingError("saveCoreData")
        }
        
        let object = NSManagedObject(entity: entity, insertInto: container.viewContext)
        
        object.setValue(UUID(), forKey: "id")
        object.setValue(image, forKey: "image")
        object.setValue(name, forKey: "name")
        object.setValue(greeting, forKey: "greeting")
        object.setValue(mbti, forKey: "mbti")
        
        do {
            try container.viewContext.save()
        } catch {
            throw ModelError.failureError("saveCoreData")
        }
    }
    
    func readCoreData() throws -> [ProfileMO] {
        do {
            return try container.viewContext.fetch(ProfileMO.fetchRequest())
        } catch {
            throw ModelError.failureError("readCoreData")
        }
    }
    
    func updateCoreData(_ data: ProfileMO) throws {
        let fetchRequest = ProfileMO.fetchRequest()
        
        guard let id = data.id else {
            throw ModelError.bindingError("dataBinding")
        }
        
        fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        
        guard let result = try? container.viewContext.fetch(fetchRequest),
              let object = result.first else {
            throw ModelError.bindingError("updateCoreData")
        }
        
        object.setValue(data.image, forKey: "image")
        object.setValue(data.name, forKey: "name")
        object.setValue(data.greeting, forKey: "greeting")
        object.setValue(data.mbti, forKey: "mbti")
        
        do {
            try container.viewContext.save()
        } catch {
            throw ModelError.failureError("updateCoreData")
        }
    }
    
    func deleteCoreData(_ data: ProfileMO) throws {
        let fetchRequest = ProfileMO.fetchRequest()
        guard let id = data.id else {
            throw ModelError.bindingError("dataBinding")
        }
        
        fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        
        guard let result = try? container.viewContext.fetch(fetchRequest),
              let object = result.first else {
            throw ModelError.bindingError("deleteCoreData")
        }
        
        container.viewContext.delete(object)
            
        do {
            try container.viewContext.save()
        } catch {
            throw ModelError.failureError("deleteCoreData")
        }
    }
}
