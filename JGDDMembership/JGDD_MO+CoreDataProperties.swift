//
//  JGDD_MO+CoreDataProperties.swift
//  JGDDMembership
//
//  Created by Neoself on 10/24/24.
//
//

import Foundation
import CoreData


extension JGDD_MO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JGDD_MO> {
        return NSFetchRequest<JGDD_MO>(entityName: "JGDD_MO")
    }

    @NSManaged public var greeting: String?
    @NSManaged public var id: UUID?
    @NSManaged public var image: String?
    @NSManaged public var mbti: String?
    @NSManaged public var name: String?

}

extension JGDD_MO : Identifiable {

}
