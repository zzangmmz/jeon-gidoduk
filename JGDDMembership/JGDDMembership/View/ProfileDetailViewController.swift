import UIKit

final class ProfileDetailViewController: UIViewController {
    private let profile: JGDD_MO
    
    // MARK: - UI Components
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.layer.borderColor = UIColor.systemGray5.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: TitleLabel = {
        let label = TitleLabel("이름")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mbtiLabel: TitleLabel = {
        let label = TitleLabel("MBTI")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mbtiValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let greetingLabel: TitleLabel = {
        let label = TitleLabel("인사말")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let greetingValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    init(profile: JGDD_MO) {
        self.profile = profile
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureProfile()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        title = "프로필 상세"
        
        let stackView = CustomStackView(spacing: 20)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center  // 이미지를 중앙 정렬하기 위해
        
        // 이름 스택뷰
        let nameStackView = CustomStackView(spacing: 8)
        nameStackView.addArrangedSubviews([nameLabel, nameValueLabel])
        
        // MBTI 스택뷰
        let mbtiStackView = CustomStackView(spacing: 8)
        mbtiStackView.addArrangedSubviews([mbtiLabel, mbtiValueLabel])
        
        // 인사말 스택뷰
        let greetingStackView = CustomStackView(spacing: 8)
        greetingStackView.addArrangedSubviews([greetingLabel, greetingValueLabel])
        
        // 정보를 담을 컨테이너 스택뷰
        let infoStackView = CustomStackView(spacing: 16)
        infoStackView.addArrangedSubviews([
            nameStackView,
            mbtiStackView,
            greetingStackView
        ])
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // 전체 스택뷰에 추가
        stackView.addArrangedSubviews([
            profileImageView,
            infoStackView
        ])
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            // 이미지뷰 크기 설정
            profileImageView.heightAnchor.constraint(equalToConstant: 150),
            profileImageView.widthAnchor.constraint(equalToConstant: 150),
            
            // 전체 스택뷰 제약조건
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            // 정보 스택뷰가 전체 너비를 사용하도록 설정
            infoStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            infoStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
    }
    
    // MARK: - Configuration
    private func configureProfile() {
        if let imageName = profile.image {
            profileImageView.image = UIImage(named: imageName)
        } else {
            profileImageView.image = UIImage(systemName: "person.circle.fill")
        }
        
        nameValueLabel.text = profile.name
        mbtiValueLabel.text = profile.mbti
        greetingValueLabel.text = profile.greeting
    }
}
