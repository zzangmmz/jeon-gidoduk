import UIKit

class ViewController: UIViewController, CreateMemberViewDelegate {

    // 멤버 정보를 표시할 라벨
    var memberInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "멤버 정보를 추가해주세요."
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 플레이스홀더 라벨
    var placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "멤버를 추가해주세요."
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네비게이션 타이틀 설정
        self.title = "전기도둑"
        
        // 오른쪽 + 버튼 추가
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        self.navigationItem.rightBarButtonItem = addButton
        
        // 배경 색상 설정
        self.view.backgroundColor = .white
        
        // 플레이스홀더 라벨 추가
        self.view.addSubview(placeholderLabel)
        setupPlaceholderConstraints()
        
        // 멤버 정보 라벨 추가
        self.view.addSubview(memberInfoLabel)
        setupMemberInfoLabelConstraints()

        // 초기에는 memberInfoLabel 숨기기
        memberInfoLabel.isHidden = true
    }

    // 플레이스홀더 라벨 레이아웃 설정
    func setupPlaceholderConstraints() {
        NSLayoutConstraint.activate([
            placeholderLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    // 멤버 정보 라벨 레이아웃 설정
    func setupMemberInfoLabelConstraints() {
        NSLayoutConstraint.activate([
            memberInfoLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            memberInfoLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            memberInfoLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8)
        ])
    }
    
    // + 버튼을 눌렀을 때 새로운 멤버 추가 화면으로 이동
    @objc func didTapAddButton() {
        let newViewController = CreateMemberViewController()
        newViewController.delegate = self
        self.navigationController?.pushViewController(newViewController, animated: true)
    }

    // CreateMemberViewDelegate 구현 (데이터 받기)
    func didTapCompleteButton(profileImage: String?, name: String, introduce: String, mbti: String?) {
        // 전달받은 데이터를 텍스트로 표시
        memberInfoLabel.text = """
        이름: \(name)
        인삿말: \(introduce)
        MBTI: \(mbti ?? "알 수 없음")
        """
        
        // 플레이스홀더 숨기기
        placeholderLabel.isHidden = true
        
        // 멤버 정보 라벨 보이기
        memberInfoLabel.isHidden = false
    }
}
