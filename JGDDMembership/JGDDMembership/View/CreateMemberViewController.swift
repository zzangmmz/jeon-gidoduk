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
        setupAddTarget()
    }
    
    private func setupAddTarget() {
        [createMemberView.eButton, createMemberView.iButton, createMemberView.sButton, createMemberView.nButton, createMemberView.tButton, createMemberView.fButton, createMemberView.jButton, createMemberView.pButton].forEach { $0.addTarget(self, action: #selector(mbtiButtonTapped), for: .touchUpInside) }
    }
    
    // TODO: - 버튼 이중선택 막기
    @objc func mbtiButtonTapped(_ button: MbtiButton) {
        if button.isClicked {
            button.backgroundColor = .clear
        } else  {
            button.backgroundColor = .gray
        }
        button.isClicked.toggle()
    }
}



