import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CreateMemberViewDelegate {

    // 멤버 데이터를 저장할 배열
    var members: [(profileImage: String?, name: String, introduce: String, mbti: String?)] = []

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

    // 테이블 뷰
    let tableView = UITableView()

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
        
        // 테이블 뷰 설정
        setupTableView()

        // 테이블 뷰는 처음에 숨김
        tableView.isHidden = true
    }

    // 플레이스홀더 라벨 레이아웃 설정
    func setupPlaceholderConstraints() {
        NSLayoutConstraint.activate([
            placeholderLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }

    // 테이블 뷰 레이아웃 설정
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false // 오토레이아웃을 사용할때 테이블뷰의 오토레이아웃을 동적으로 정해주려면 false를 해야하나보군,
        tableView.delegate = self
        tableView.dataSource = self// 테이블 데이터를 관리하려면 필요한 녀석
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
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
        // 새로운 멤버 추가
        let newMember = (profileImage: profileImage, name: name, introduce: introduce, mbti: mbti)
        members.append(newMember)
        
        // 테이블 뷰에 멤버 데이터가 있으면 플레이스홀더 숨기고 테이블 뷰 보이기
        if members.count > 0 {
            placeholderLabel.isHidden = true
            tableView.isHidden = false
        }
        
        // 테이블 뷰 갱신
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // UITableViewDataSource 메서드 (테이블 뷰에 멤버 데이터를 표시)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let member = members[indexPath.row]
        cell.textLabel?.text = "\(member.name) - \(member.mbti ?? "MBTI 없음")"
        cell.imageView?.image = UIImage(named: member.profileImage ?? "person.fill")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // 왼쪽으로 슬라이드하여 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            members.remove(at: indexPath.row)
            
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
           
            if members.isEmpty {
                placeholderLabel.isHidden = false
                tableView.isHidden = true
            }
        }
    }
}
