// 0. MainViewController와 CreateMemberViewController 간의 통신을 위한 위임자 프로토콜 생성
protocol CreateMemberViewDelegate: AnyObject {
    // 2. didTapCompleteButton을 감시하고 있던 Delegate가 활성화?
    func didTapCompleteButton(image: String?, name: String, greeting: String, mbti: String?)
}
