import UIKit

final class CreateMemberViewController: UIViewController {
    
    private let createMemberView = CreateMemberView()
    weak var delegate: CreateMemberDelegate?
    
    override func loadView() {
        view = createMemberView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        hideKeyboardWhenTappedAround()
        createMemberView.configure(with: self)  // 이 라인이 필요합니다!
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "←",
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
    }
    
    @objc private func backButtonTapped() {
        showExitConfirmationAlert()
    }
    
    private func showExitConfirmationAlert() {
        let alert = UIAlertController(
            title: "나가시겠습니까?",
            message: nil,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "예", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        
        alert.addAction(UIAlertAction(title: "아니요", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(
            title: "오류",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
    func createMember(image: String?, name: String, greeting: String, mbti: String?) {
        do {
            let _ = try ProfileManager.shared.createProfile(
                name: name,
                greeting: greeting,
                mbti: mbti,
                image: image
            )
            
            print("createMember in viewController")
            // MainViewController에 알림
            delegate?.didCreateMember(image: image, name: name, greeting: greeting, mbti: mbti)
            print("createMember in viewController")
            navigationController?.popViewController(animated: true)
        } catch {
            print(error.localizedDescription)
        }
    }
}

// 화면 터치로 키보드 내리기
extension CreateMemberViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
