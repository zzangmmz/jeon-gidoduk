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
    }
}



