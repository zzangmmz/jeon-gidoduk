import CoreData
import UIKit

// MARK: - 프로필 관련 에러 정의
enum ProfileError: Error {
    case creationFailed
    case updateFailed
    case deletionFailed
    case fetchFailed
    case invalidData
    
    var localizedDescription: String {
        switch self {
        case .creationFailed: return "프로필 생성에 실패했습니다"
        case .updateFailed: return "프로필 업데이트에 실패했습니다"
        case .deletionFailed: return "프로필 삭제에 실패했습니다"
        case .fetchFailed: return "프로필 조회에 실패했습니다"
        case .invalidData: return "유효하지 않은 프로필 데이터입니다"
        }
    }
}

// MARK: - 프로필 관리자
final class ProfileManager {
    static let shared = ProfileManager() // 싱글톤
    private let context: NSManagedObjectContext // 추후 Core Data로부터 fetch하는 데이터 저장용도
    
    private init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("AppDelegate를 찾을 수 없습니다")
        }
        self.context = appDelegate.persistentContainer.viewContext
        // AppDelegate 단에 선언된 persistentContainer로부터 CoreData 메서드 불러오기
    }
    
    // MARK: - 기본 CRUD
    
    /// 새 프로필 생성
    func createProfile(name: String?, greeting: String?, mbti: String?, image: String?, id: UUID = UUID()) throws -> JGDD_MO {
        // 1. 모델 구조를 불러옴
        // 2. 해당 구조에 인자로 받은 데이터 주입
        // 3. persistentContainer에 저장
        
        let profile = JGDD_MO(context: context)
        profile.id = id
        profile.name = name
        profile.greeting = greeting
        profile.mbti = mbti
        profile.image = image
        
        do {
            try context.save()
            NotificationCenter.default.post(name: .memberDataDidChange, object: nil)
            return profile
        } catch {
            // 만일 에러 발생 시, CoreData 객체에 발생할 수 있는 사이드 이펙 막기 위해 이전 상태로 롤백
            context.rollback()
            throw ProfileError.creationFailed
        }
    }
    
    /// 모든 프로필 조회
    func fetchProfiles() throws -> [JGDD_MO] {
        let fetchRequest: NSFetchRequest<JGDD_MO> = JGDD_MO.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            throw ProfileError.fetchFailed
        }
    }
    
    /// ID로 특정 프로필 조회
    func fetchProfile(withId id: UUID) throws -> JGDD_MO? {
        let fetchRequest: NSFetchRequest<JGDD_MO> = JGDD_MO.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        fetchRequest.fetchLimit = 1
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            throw ProfileError.fetchFailed
        }
    }
    
    /// 프로필 정보 업데이트
    func updateProfile(_ profile: JGDD_MO, name: String? = nil, greeting: String? = nil, mbti: String? = nil, image: String? = nil) throws {
        if let name = name {
            profile.name = name
        }
        if let greeting = greeting {
            profile.greeting = greeting
        }
        if let mbti = mbti {
            profile.mbti = mbti
        }
        if let image = image {
            profile.image = image
        }
        
        do {
            try context.save()
            NotificationCenter.default.post(name: .memberDataDidChange, object: nil)
        } catch {
            context.rollback()
            throw ProfileError.updateFailed
        }
    }
    
    /// 프로필 삭제
    func deleteProfile(_ profile: JGDD_MO) throws {
        context.delete(profile)
        
        do {
            try context.save()
        } catch {
            context.rollback()
            throw ProfileError.deletionFailed
        }
    }
    
    // MARK: - 백그라운드 작업
    
    /// 백그라운드에서 데이터 처리
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        appDelegate.persistentContainer.performBackgroundTask { context in
            block(context)
            
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    print("백그라운드 작업 중 오류 발생: \(error)")
                }
            }
        }
    }
}

// MARK: - JGDD_MO 편의 확장
extension JGDD_MO {
    /// 표시용 이름
    var displayName: String {
        name ?? "이름 없음"
    }
    
    /// 표시용 인사말
    var displayGreeting: String {
        greeting ?? "안녕하세요!"
    }
    
    /// 표시용 MBTI
    var displayMBTI: String {
        mbti ?? "미설정"
    }
}
