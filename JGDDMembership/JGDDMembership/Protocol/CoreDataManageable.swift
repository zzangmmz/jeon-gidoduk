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
        //저장할 Entity 가져오기
        guard let entity = NSEntityDescription.entity(forEntityName: "Profile", in: container.viewContext) else {
            throw ModelError.bindingError("saveCoreData")
        }
        
        //해당 entity에 저장할 NSManagedObject를 생성
        let object = NSManagedObject(entity: entity, insertInto: container.viewContext)
        
        //그 안에 정보들을 저장.
        object.setValue(UUID(), forKey: "id")
        object.setValue(image, forKey: "image")
        object.setValue(name, forKey: "name")
        object.setValue(greeting, forKey: "greeting")
        object.setValue(mbti, forKey: "mbti")
        
        //저장
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
        
        //predicate를 통해 특정한 객체만 가져오도록 설정한다. UUID는 유일하게 가지고 있다고 볼 수 있기에 이를 사용한다.
        fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        
        //만들어 두었던 fetchRequest를 통해 fetch한다. fetch된 결과물이 배열이기에 첫번째 것을 가져다가 사용한다.
        guard let result = try? container.viewContext.fetch(fetchRequest),
              let object = result.first else {
            throw ModelError.bindingError("updateCoreData")
        }
        
        //값 수정.(업데이트)
        object.setValue(data.image, forKey: "image")
        object.setValue(data.name, forKey: "name")
        object.setValue(data.greeting, forKey: "greeting")
        object.setValue(data.mbti, forKey: "mbti")
        
        //수정한 내용 저장
        do {
            try container.viewContext.save()
        } catch {
            throw ModelError.failureError("updateCoreData")
        }
    }
    
    func deleteCoreData(_ data: ProfileMO) throws {
        //update와 같다.
        let fetchRequest = ProfileMO.fetchRequest()
        guard let id = data.id else {
            throw ModelError.bindingError("dataBinding")
        }
        
        fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        
        guard let result = try? container.viewContext.fetch(fetchRequest),
              let object = result.first else {
            throw ModelError.bindingError("deleteCoreData")
        }
        
        //찾은 객체를 삭제한다.
        container.viewContext.delete(object)
            
        //삭제했다는 것을 저장한다.
        do {
            try container.viewContext.save()
        } catch {
            throw ModelError.failureError("deleteCoreData")
        }
    }
}
