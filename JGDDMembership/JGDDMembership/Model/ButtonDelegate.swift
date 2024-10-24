//
//  MbtiButtonDelegate.swift
//  JGDDMembership
//
//  Created by 이명지 on 10/23/24.
//

// 프로토콜 정의
protocol MbtiButtonDelegate: AnyObject {
    func mbtiButtonTapped(_ button: MbtiButton)
}

// 기본 구현 제공
extension MbtiButtonDelegate {
    func handleMbtiSelection(_ mbti: String, for profile: JGDD_MO) {
        do {
            try ProfileManager.shared.updateProfile(profile, mbti: mbti)
        } catch {
            print("MBTI 업데이트 실패: \(error.localizedDescription)")
        }
    }
}

// MARK: - ProfileButton
protocol ProfileButtonDelegate: AnyObject {
    func ProfileButtonTapped(_ button: ProfileImageButton)
}

extension ProfileButtonDelegate {
    /// 프로필 이미지 업데이트 처리
    func handleProfileImageUpdate(_ imageString: String, for profile: JGDD_MO) {
        do {
            try ProfileManager.shared.updateProfile(profile, image: imageString)
        } catch {
            print("프로필 이미지 업데이트 실패: \(error.localizedDescription)")
        }
    }
}
