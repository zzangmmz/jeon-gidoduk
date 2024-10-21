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
        // Do any additional setup after loading the view.
        setupAddTarget()
    }
    
    private func setupAddTarget() {
        [createMemberView.eButton, createMemberView.iButton, createMemberView.sButton, createMemberView.nButton, createMemberView.tButton, createMemberView.fButton, createMemberView.jButton, createMemberView.pButton].forEach { $0.addTarget(self, action: #selector(mbtiButtonTapped), for: .touchUpInside) }
    }
    
    
    // 이중선택 막아야 함
    @objc func mbtiButtonTapped(_ button: UIButton) {
        if button.backgroundColor == .gray {
            button.backgroundColor = .clear
        } else if button.backgroundColor == .clear {
            button.backgroundColor = .gray
        }
    }
}



