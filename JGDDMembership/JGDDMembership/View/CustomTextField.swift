//
//  CustomTextField.swift
//  JGDDMembership
//
//  Created by 이명지 on 10/22/24.
//

import UIKit

final class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.placeholder = "최대 10자까지 입력 가능해요."
        self.layer.cornerRadius = 10
        self.borderStyle = .roundedRect
    }
}
