//
//  TitleLabel.swift
//  JGDDMembership
//
//  Created by 이명지 on 10/22/24.
//
import UIKit

final class TitleLabel: UILabel {
    init(_ title: String) {
        super.init(frame: .zero)
        
        setup(title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(_ title: String) {
        self.text = title
        self.textColor = .black
        self.font = .boldSystemFont(ofSize: 16)
    }
}
