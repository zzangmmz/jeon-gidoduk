import Foundation
import CoreData

@objc(JGDD_MO)
// Core Data 모델
public class JGDD_MO: NSManagedObject {
}

extension JGDD_MO {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<JGDD_MO> {
        // NS는 NextStep의 약자로 UIKit의 많은 기본클래스들이 해당 접두어 갖고 있음.
        return NSFetchRequest<JGDD_MO>(entityName: "JGDD_MO")
    }

    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var greeting: String?
    @NSManaged public var mbti: String?
    @NSManaged public var id: UUID?

}

extension JGDD_MO : Identifiable {

}

