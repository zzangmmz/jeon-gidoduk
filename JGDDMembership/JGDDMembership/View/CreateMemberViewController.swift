//
//  CreateMemberViewController.swift
//  JGDDMembership
//
//  Created by JGDDMembership on 10/21/24.
//

import UIKit

final class CreateMemberViewController: UIViewController , CreateMemberViewDelegate {
    func didTapCompleteButton() {
        self.navigationController?.popViewController(animated: true) // 네비게이션 팝 없애버리기
    }
    
    private let createMemberView = CreateMemberView()
    
    override func loadView() {
        view = createMemberView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(backButtonTapped))
        
        createMemberView.delegate = self // 딜리게이트로 홈화면에 넘겨주기
    }
    
    @objc private func backButtonTapped() {
        showExitConfirmationAlert()
    }
    
    // alert 설정
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
    
    @objc func completeButtonTapped() {
        let data = createMemberView.collectData()
        print("Profile Image: \(data.profileImage ?? "profile1")")
        print("Name: \(data.name)")
        print("Introduce: \(data.introduce)")
        print("MBTI: \(data.mbti ?? " ")")
    }
}


// 화면 터치해서 키보드 내리기
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



