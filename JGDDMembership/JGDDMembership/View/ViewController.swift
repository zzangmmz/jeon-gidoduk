import UIKit

class ViewController: UIViewController {

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
    }
    
    // 플레이스홀더 레이아웃 설정
    func setupPlaceholderConstraints() {
        NSLayoutConstraint.activate([
            placeholderLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    // + 버튼 눌렀을 때 호출되는 메서드
    @objc func didTapAddButton() {
        let newViewController = CreateMemberViewController() // 새로 이동할 뷰컨트롤러 (미리 정의된 화면이어야 함)
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}
