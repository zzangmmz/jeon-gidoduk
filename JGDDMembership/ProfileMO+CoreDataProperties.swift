//
//  ProfileMO+CoreDataProperties.swift
//  JGDDMembership
//
//  Created by minsong kim on 10/21/24.
//
//

import Foundation
import CoreData


extension ProfileMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProfileMO> {
        return NSFetchRequest<ProfileMO>(entityName: "ProfileMO")
    }

    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var greeting: String?
    @NSManaged public var mbti: String?
    @NSManaged public var id: UUID?

}

extension ProfileMO : Identifiable {

}
