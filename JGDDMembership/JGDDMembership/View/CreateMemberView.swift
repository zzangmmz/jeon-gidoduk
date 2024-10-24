//
//  CreateMemberView.swift
//  JGDDMembership
//
//  Created by 이명지 on 10/21/24.
//

import UIKit

final class CreateMemberView: UIView {
    // MARK: - UI 컴포넌트 세팅
    weak var delegate: CreateMemberViewDelegate? // 위임자 내부에 있는 didTapCompleteButton 사용하기 위해 약한 참조
    private let profileLabel = TitleLabel("프로필 이미지")
    private let profileImageButton1 = ProfileImageButton("profile1")
    private let profileImageButton2 = ProfileImageButton("profile2")
    
    private let nameLabel = TitleLabel("이름")
    private let nameTextField = CustomTextField()
    
    private let introduceLabel = TitleLabel("인삿말")
    private let introduceTextField = CustomTextField()
    
    private let mbtiLabel = TitleLabel("MBTI")
    let eButton = MbtiButton("E")
    let iButton = MbtiButton("I")
    let nButton = MbtiButton("N")
    let sButton = MbtiButton("S")
    let tButton = MbtiButton("T")
    let fButton = MbtiButton("F")
    let jButton = MbtiButton("J")
    let pButton = MbtiButton("P")
    
    private let completeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 5
        button.setTitle("저장", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        return button
    }()
    
    private let totalStackView = CustomStackView(spacing: 30)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDelegates()
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDelegates() {
        nameTextField.delegate = self
        introduceTextField.delegate = self
        [eButton, iButton, nButton, sButton, tButton, fButton, jButton, pButton].forEach { $0.delegate = self }
        [profileImageButton1, profileImageButton2].forEach { $0.delegate = self}
    }
    
    // MARK: - 스택뷰 세팅
    private func setUI() {
        backgroundColor = .white
        
        // 프로필 스택뷰
        let profileImageStackView = CustomStackView(axis: .horizontal)
        profileImageStackView.addArrangedSubviews([profileImageButton1, profileImageButton2])
        let profileStackView = CustomStackView()
        profileStackView.addArrangedSubviews([profileLabel, profileImageStackView])
        
        // 이름 스택뷰
        let nameStackView = CustomStackView()
        nameStackView.addArrangedSubviews([nameLabel, nameTextField])
        
        // 인삿말 스택뷰
        let introduceStackView = CustomStackView()
        introduceStackView.addArrangedSubviews([introduceLabel, introduceTextField])
        
        // MBTI 스택뷰
        // TODO: - collectionView로 수정
        let eiStackView = CustomStackView(axis: .horizontal, distribution: .fillEqually)
        eiStackView.addArrangedSubviews([eButton, iButton])
        let nsStackView = CustomStackView(axis: .horizontal, distribution: .fillEqually)
        nsStackView.addArrangedSubviews([nButton, sButton])
        let tfStackView = CustomStackView(axis: .horizontal, distribution: .fillEqually)
        tfStackView.addArrangedSubviews([tButton, fButton])
        let jpStackView = CustomStackView(axis: .horizontal, distribution: .fillEqually)
        jpStackView.addArrangedSubviews([jButton, pButton])
        let mbtiStackView = CustomStackView()
        mbtiStackView.addArrangedSubviews([mbtiLabel, eiStackView, nsStackView, tfStackView, jpStackView])
        
        // 전체 스택뷰
        totalStackView.addArrangedSubviews([profileStackView, nameStackView, introduceStackView, mbtiStackView, completeButton])
        completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)  // 올바르게 액션을 설정
        addSubview(totalStackView)
    }
    
    // MARK: - constraints 세팅
    private func setConstraints() {
        totalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            totalStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            totalStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            totalStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            totalStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8)
        ])
    }
    
    @objc private func completeButtonTapped() {
        let image: String? = profileImageButton1.isTapped ? profileImageButton1.imageName : profileImageButton2.isTapped ? profileImageButton2.imageName : nil
        let name = nameTextField.text ?? " "
        let greeting = introduceTextField.text ?? " "
        let mbti = [eButton, iButton, nButton, sButton, tButton, fButton, jButton, pButton].compactMap { $0.isTapped ? $0.titleLabel?.text : nil }.joined()
        // 1. delegate 내부 메서드 호출
        delegate?.didTapCompleteButton(image: image, name: name, greeting: greeting, mbti: mbti)
    }
}


extension CreateMemberView: UITextFieldDelegate {
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        // 공백만 입력된 경우
        if let text = textField.text, text.count == 1, text.first == " " {
            textField.text = ""
            return
        }
        
        // 저장 버튼 활성화 여부 결정
        guard let name = nameTextField.text, !name.isEmpty,
              let introduce = introduceTextField.text, !introduce.isEmpty,
              profileImageButton1.isTapped != profileImageButton2.isTapped,
              eButton.isTapped != iButton.isTapped,
              nButton.isTapped != sButton.isTapped,
              tButton.isTapped != fButton.isTapped,
              jButton.isTapped != pButton.isTapped else {
            completeButton.backgroundColor = .gray
            completeButton.isEnabled = false
            return
        }
        completeButton.backgroundColor = .black
        completeButton.isEnabled = true
    }
    
    // 엔터 누르면 키보드 내림
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension CreateMemberView: MbtiButtonDelegate {
    func mbtiButtonTapped(_ button: MbtiButton) {
        button.isTapped.toggle()
        
        switch button {
        case eButton:
            iButton.isTapped = false
        case iButton:
            eButton.isTapped = false
        case nButton:
            sButton.isTapped = false
        case sButton:
            nButton.isTapped = false
        case tButton:
            fButton.isTapped = false
        case fButton:
            tButton.isTapped = false
        case jButton:
            pButton.isTapped = false
        default:
            jButton.isTapped = false
        }
        
        updateCompleteButtonState()
    }
    
    private func updateCompleteButtonState() {
        guard let name = nameTextField.text, !name.isEmpty,
              let introduce = introduceTextField.text, !introduce.isEmpty,
              profileImageButton1.isTapped != profileImageButton2.isTapped, // 하나의 프로필 이미지 버튼이 선택되어야 함
              (eButton.isTapped || iButton.isTapped),  // E 또는 I 버튼이 눌린 상태여야 함
              (nButton.isTapped || sButton.isTapped),  // N 또는 S 버튼이 눌린 상태여야 함
              (tButton.isTapped || fButton.isTapped),  // T 또는 F 버튼이 눌린 상태여야 함
              (jButton.isTapped || pButton.isTapped)   // J 또는 P 버튼이 눌린 상태여야 함
        else {
            completeButton.backgroundColor = .gray
            completeButton.isEnabled = false
            return
        }
        
        completeButton.backgroundColor = .black
        completeButton.isEnabled = true
    }
}

extension CreateMemberView: ProfileButtonDelegate {
    func ProfileButtonTapped(_ button: ProfileImageButton) {
        button.isTapped.toggle()
        
        if button == profileImageButton1 {
            profileImageButton2.isTapped = false
        } else if button == profileImageButton2 {
            profileImageButton1.isTapped = false
        }
    }
}
