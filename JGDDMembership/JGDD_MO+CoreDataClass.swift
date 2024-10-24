import Foundation
import CoreData

@objc(JGDD_MO)
// Core Data가 관리하는 JGDD 엔터디의 인스턴스
// - Core Data가 해당 객체의 생명주기를 관리함
// - 데이터베이스와의 동기화를 자동으로 처리함
// - 변경을 자동으로 추적해줌
// - 저장이 필요한 시점을 CoreData가 확인할 수 있음

// 뒤에 MO를 붙여 일반모델 객체와 구분.
public class JGDD_MO: NSManagedObject {
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

