//
//  CreateMemberViewController.swift
//  JGDDMembership
//
//  Created by JGDDMembership on 10/21/24.
//

import UIKit

final class CreateMemberViewController: UIViewController {
    private let createMemberView = CreateMemberView()
    
    override func loadView() {
        view = createMemberView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(backButtonTapped))
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



