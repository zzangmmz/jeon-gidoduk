//
//  CreateMemberView.swift
//  JGDDMembership
//
//  Created by 이명지 on 10/21/24.
//

import UIKit

class CreateMemberView: UIView {
    // '프로필' 레이블
    private let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "프로필"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    // 프로필 선택 이미지1
    // 🚨 --> 버튼으로 수정 필요?
    private var profileImageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile1")
        imageView.frame.size.height = 40
        return imageView
    }()
    
    // 프로필 선택 이미지2
    // 🚨 --> 버튼으로 수정 필요?
    private var profileImageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile2")
        imageView.frame.size.height = 40
        return imageView
    }()
    
    private lazy var profileImageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImageView1, profileImageView2])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileLabel, profileImageStackView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    // '이름' 레이블
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    // 이름 입력 텍스트 필드
    private var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "최대 10자까지 입력 가능해요."
        textField.layer.cornerRadius = 10
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var nameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    // '인삿말' 레이블
    private let introduceLabel: UILabel = {
        let label = UILabel()
        label.text = "인삿말"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    // 인삿말 입력 텍스트 필드
    private var introduceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "최대 10자까지 입력 가능해요."
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var introduceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [introduceLabel, introduceTextField])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    // 'MBTI' 레이블
    private let mbtiLabel: UILabel = {
        let label = UILabel()
        label.text = "MBTI"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    var eButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("E", for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    var iButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("I", for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var eiStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [eButton, iButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    var nButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("N", for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    var sButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("S", for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var nsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nButton, sButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    var tButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("T", for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    var fButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("F", for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var tfStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tButton, fButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    var jButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("J", for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    var pButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("P", for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var jpStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [jButton, pButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var mbtiStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mbtiLabel ,eiStackView, nsStackView, tfStackView, jpStackView])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private var completeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 5
        button.setTitle("저장", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false

        return button
    }()
    
    private lazy var totalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileStackView, nameStackView, introduceStackView, mbtiStackView, completeButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
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
        // 텍스트 필드 채워져있는지 검사
        // 🚨 프로필 선택했는지, 엠비티아이 선택했는지, 엠비티아이 정상적으로 체크됐는지 검사 추가 필요
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
