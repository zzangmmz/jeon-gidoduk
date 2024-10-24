import UIKit



final class CreateMemberViewController: UIViewController {
    
    weak var delegate: CreateMemberViewDelegate? // 데이터를 전달할 Delegate
    
    private let createMemberView = CreateMemberView() // 멤버 정보를 입력받는 뷰
    
    override func loadView() {
        view = createMemberView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뒤로 가기 버튼 설정
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(backButtonTapped))
        
//         createMemberView의 delegate 설정
        createMemberView.delegate = self
        
        // 키보드를 화면 터치로 내릴 수 있도록 설정
        hideKeyboardWhenTappedAround()
    }
    
    @objc private func backButtonTapped() {
        showExitConfirmationAlert()
    }
    
    // 나가기 경고창 설정
    private func showExitConfirmationAlert() {
        let alert = UIAlertController(title: "나가시겠습니까?", message: nil, preferredStyle: .alert)
        
        let yes = UIAlertAction(title: "예", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        let no = UIAlertAction(title: "아니요", style: .cancel)
        
        alert.addAction(yes)
        alert.addAction(no)
        
        present(alert, animated: true, completion: nil)
    }
    
//    @objc func completeButtonTapped() {
//        let data = createMemberView.collectData()
//        
//        // 데이터를 Delegate를 통해 ViewController에 전달
//       // delegate?.didAddMember(profileImage: data.profileImage, name: data.name, introduce: data.introduce, mbti: data.mbti)
//        
//        // 이전 화면으로 이동
////        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
//
//    }
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
//여기에서 데이터를 받는 거고 
extension CreateMemberViewController : CreateMemberViewDelegate {
    func didTapCompleteButton(profileImage: String?, name: String, introduce: String, mbti: String?) {
        delegate?.didTapCompleteButton(profileImage: profileImage, name: name, introduce: introduce, mbti: mbti)
                self.navigationController?.popViewController(animated: true)
    }
    
    
}
