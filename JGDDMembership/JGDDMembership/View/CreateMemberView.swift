//
//  CreateMemberView.swift
//  JGDDMembership
//
//  Created by 이명지 on 10/21/24.
//

import UIKit

final class CreateMemberView: UIView {
    // MARK: - 프로필
    private let profileLabel = TitleLabel("타이틀")
    private var profileImageView1 = ProfileImageView("profile1")
    private var profileImageView2 = ProfileImageView("profile2")
    private lazy var profileImageStackView = CustomStackView(arrangedSubviews: [profileImageView1, profileImageView2], axis: .horizontal)
    private lazy var profileStackView = CustomStackView(arrangedSubviews: [profileLabel, profileImageStackView])
    
    // MARK: - 이름
    private let nameLabel = TitleLabel("이름")
    private var nameTextField = CustomTextField()
    private lazy var nameStackView = CustomStackView(arrangedSubviews: [nameLabel, nameTextField])
    
    // MARK: - 인삿말
    private let introduceLabel = TitleLabel("인삿말")
    private var introduceTextField = CustomTextField()
    private lazy var introduceStackView = CustomStackView(arrangedSubviews: [introduceLabel, introduceTextField])
    
    // MARK: - MBTI
    // TODO: - 컬렉션뷰로 변경 필요
    private let mbtiLabel = TitleLabel("MBTI")
    
    var eButton = MbtiButton("E")
    var iButton = MbtiButton("I")
    private lazy var eiStackView = CustomStackView(arrangedSubviews: [eButton, iButton], axis: .horizontal)
    
    var nButton = MbtiButton("N")
    var sButton = MbtiButton("S")
    private lazy var nsStackView = CustomStackView(arrangedSubviews: [nButton, sButton], axis: .horizontal)
    
    var tButton = MbtiButton("T")
    var fButton = MbtiButton("F")
    private lazy var tfStackView = CustomStackView(arrangedSubviews: [tButton, fButton], axis: .horizontal)
    
    var jButton = MbtiButton("J")
    var pButton = MbtiButton("P")
    private lazy var jpStackView = CustomStackView(arrangedSubviews: [jButton, pButton], axis: .horizontal)
    
    private lazy var mbtiStackView = CustomStackView(arrangedSubviews: [mbtiLabel ,eiStackView, nsStackView, tfStackView, jpStackView])
    
    // MARK: - 저장 버튼
    private var completeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 5
        button.setTitle("저장", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false

        return button
    }()
    
    private lazy var totalStackView = CustomStackView(arrangedSubviews: [profileStackView, nameStackView, introduceStackView, mbtiStackView, completeButton], spacing: 20)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = .white
        nameTextField.delegate = self
        introduceTextField.delegate = self
        addSubview(totalStackView)
    }
    
    func setConstraints() {
        totalStackView.translatesAutoresizingMaskIntoConstraints = false
        totalStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        totalStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}

extension CreateMemberView: UITextFieldDelegate {
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        
        // TODO: - 프로필 선택했는지, 엠비티아이 선택했는지, 엠비티아이 정상적으로 체크됐는지 검사 추가 필요
        guard
            let name = nameTextField.text, !name.isEmpty,
            let introduce = introduceTextField.text, !introduce.isEmpty
        else {
            completeButton.backgroundColor = .gray
            completeButton.isEnabled = false
            return
        }
        completeButton.backgroundColor = .black
        completeButton.isEnabled = true
    }
}
