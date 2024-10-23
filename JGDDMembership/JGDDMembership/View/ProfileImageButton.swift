//
//  ProfileImageButton.swift
//  JGDDMembership
//
//  Created by 이명지 on 10/23/24.
//
import UIKit

final class ProfileImageButton: UIButton {
    private var _isTapped: Bool = false
    var delegate: ProfileButtonDelegate?
    
    var isTapped: Bool {
        get {
            return _isTapped
        }
        set {
            _isTapped = newValue
            self.layer.borderColor = self.isTapped ? #colorLiteral(red: 0.4834698439, green: 0.756084621, blue: 0.4131345749, alpha: 1) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
    
    init(_ image: String) {
        super.init(frame: .zero)
        
        setup(image)
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(_ image: String) {
        self.setImage(UIImage(named: image), for: .normal)
        
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 7
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.imageView?.contentMode = .scaleAspectFill
    }
    
    private func setAddTarget() {
        self.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
    }
    
    @objc private func profileButtonTapped() {
        delegate?.ProfileButtonTapped(self)
    }
}
