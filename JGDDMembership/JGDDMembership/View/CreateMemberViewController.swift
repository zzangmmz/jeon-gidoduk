import UIKit

final class CreateMemberViewController: UIViewController {
    
    private let createMemberView = CreateMemberView()
    
    override func loadView() {
        view = createMemberView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        // 1. CreateMemberViewController가 CreateMemberView의 delegate(CreateMemberViewDelegate)가 되면서, CreateMemberView의 이벤트(didTapCompleteButton)를 수신할 수 있게 됨.
        createMemberView.delegate = self
        hideKeyboardWhenTappedAround()
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


extension CreateMemberViewController: CreateMemberViewDelegate {
    // 3. CreateMemberView에서 완료 버튼이 탭되면 이 메서드가 호출됨
    func didTapCompleteButton(image: String?, name: String, greeting: String, mbti: String?) {
        do {
            let _ = try ProfileManager.shared.createProfile(
                name: name,
                greeting: greeting,
                mbti: mbti,
                image: image
            )
            // CreateMemberView가 Pop 되면서 뒤로감.
            navigationController?.popViewController(animated: true)
        } catch {
            print(error.localizedDescription)
        }
    }
}
