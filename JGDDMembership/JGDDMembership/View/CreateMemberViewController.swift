import UIKit

final class CreateMemberViewController: UIViewController {
    
    private let createMemberView = CreateMemberView()
    weak var delegate: CreateMemberViewDelegate? // 데이터를 전달할 Delegate
    
    
    override func loadView() {
        view = createMemberView
    }
    
    override func viewDidLoad() {
           super.viewDidLoad()
           setupNavigationBar()
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

// 여기에서 데이터를 받는 거고
//extension CreateMemberViewController : CreateMemberViewDelegate {
//    func didTapCompleteButton(profileImage: String?, name: String, introduce: String, mbti: String?) {
//        delegate?.didTapCompleteButton(profileImage: profileImage, name: name, introduce: introduce, mbti: mbti)
//                self.navigationController?.popViewController(animated: true)
//    }
//}
extension CreateMemberViewController: CreateMemberViewDelegate {
    func didTapCompleteButton(profileImage: String?, name: String, introduce: String, mbti: String?) {
        do {
            let result = try ProfileManager.shared.createProfile(
                name: name,
                greeting: introduce,
                mbti: mbti,
                image: profileImage
            )
            navigationController?.popViewController(animated: true)
        } catch {
            print(error.localizedDescription)
        }
    }
}
