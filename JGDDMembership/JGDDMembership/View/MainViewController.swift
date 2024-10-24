import UIKit

class MainViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "멤버를 추가해주세요."
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleDataChange),
            name: .memberDataDidChange,
            object: nil
        )
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setupTableView()
        setupPlaceholder()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupPlaceholder() {
        view.addSubview(placeholderLabel)
        NSLayoutConstraint.activate([
            placeholderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        title = "전기도둑"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapAddButton)
        )
    }
    
    // MARK: - Actions
    // + 버튼을 눌렀을 때 새로운 멤버 추가 화면으로 이동
    @objc private func didTapAddButton() {
        let newViewController = CreateMemberViewController()
//        newViewController.delegate = self
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc private func handleDataChange() {
        print("data changed")
        loadProfiles()
    }
    
    // MARK: - Data Loading
    private func loadProfiles() {
        do {
            let profiles = try ProfileManager.shared.fetchProfiles()
            updateUI(isEmpty: profiles.isEmpty)
            tableView.reloadData()
        } catch {
            showError(message: "프로필을 불러오는데 실패했습니다")
        }
    }
    
    private func updateUI(isEmpty: Bool) {
        if isEmpty {
            placeholderLabel.isHidden = false
            tableView.isHidden = true
        } else {
            placeholderLabel.isHidden = true
            tableView.isHidden = false
        }
    }
    
    private func showError(message: String) {
        let alert = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - TableView Delegate 및 데이터 처리 구문
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    // TableView 행 개수 산정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do {
            return try ProfileManager.shared.fetchProfiles().count
        } catch {
            return 0
        }
    }
    
    // Cell 선택 시 실행되는 메서드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        do {
            let profiles = try ProfileManager.shared.fetchProfiles()
            let selectedProfile = profiles[indexPath.row]
            let detailVC = ProfileDetailViewController(profile: selectedProfile)
            navigationController?.pushViewController(detailVC, animated: true)
        } catch {
            showError(message: "프로필을 불러올 수 없습니다")
        }
    }
    
    // 테이블 뷰 데이터 전달 및 렌더링 로직
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        do {
            let profiles = try ProfileManager.shared.fetchProfiles()
            if !profiles.isEmpty { self.placeholderLabel.isHidden = true }
            
            let member = profiles[indexPath.row]
            cell.textLabel?.text = "\(member.name ?? "사용자") - \(member.mbti ?? "MBTI 없음")"
            cell.imageView?.image = UIImage(named: member.image ?? "person.fill")
        } catch {
            cell.textLabel?.text = "오류 발생"
        }
        return cell
    }
    
    // 스와이핑으로 삭제 처리 시 호출되는 메서드
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        do {
            let profiles = try ProfileManager.shared.fetchProfiles()
            let profileToDelete = profiles[indexPath.row]
            
            try ProfileManager.shared.deleteProfile(profileToDelete)
            loadProfiles()
        } catch {
            showError(message: "프로필 삭제에 실패했습니다")
        }
    }
}

// CreateMemberViewDelegate 구현 (데이터 받기)
extension MainViewController: CreateMemberViewDelegate {
    func didTapCompleteButton(image: String?, name: String, greeting: String, mbti: String?) {
        // 테이블 뷰 갱신
        tableView.reloadData()
    }
}
