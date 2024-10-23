//
//  MbtiButton.swift
//  JGDDMembership
//
//  Created by 이명지 on 10/22/24.
//

import UIKit

final class MbtiButton: UIButton {
    private var _isTapped: Bool = false
    var delegate: MbtiButtonDelegate?
    
    var isTapped: Bool {
        get {
            return _isTapped
        }
        set {
            _isTapped = newValue
            self.backgroundColor = _isTapped ? .gray : .clear
        }
    }
    
    init(_ title: String) {
        super.init(frame: .zero)
        
        setup(title)
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(_ title: String) {
        self.setTitle(title, for: .normal)
        self.backgroundColor = .clear
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        self.setTitleColor(.black, for: .normal)
    }
    
    private func setAddTarget() {
        self.addTarget(self, action: #selector(mbtiButtonTapped), for: .touchUpInside)
    }
    
    @objc private func mbtiButtonTapped() {
        delegate?.mbtiButtonTapped(self)
    }
}
