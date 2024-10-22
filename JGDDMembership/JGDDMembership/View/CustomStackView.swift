//
//  CustomStackView.swift
//  JGDDMembership
//
//  Created by 이명지 on 10/22/24.
//

import UIKit

class CustomStackView: UIStackView {
    init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis = .vertical, spacing: CGFloat = 10, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fillEqually) {
        super.init(frame: .zero)
        
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

