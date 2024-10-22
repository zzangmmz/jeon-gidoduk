//
//  ProfileImageView.swift
//  JGDDMembership
//
//  Created by 이명지 on 10/22/24.
//

import UIKit

// TODO: - 커스텀 UIButton으로 변경 필요
final class ProfileImageView: UIImageView {
    init(_ image: String) {
        super.init(frame: .zero)
        
        setup(image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(_ image: String) {
        self.image = UIImage(named: image)
        self.frame.size.height = 40
    }
}

