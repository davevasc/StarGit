//
//  UserDetailView.swift
//  StarGit
//
//  Created by David Vicente on 30/3/22.
//

import UIKit

class UserDetailView: UIViewController {
    
    // MARK: - External vars
    var username: String = ""
    
    // MARK: - Internal vars
    private var user: UserModel?
    private let vm = GitViewModel()
    
    // MARK: - UI Elements
    //Lazy Var para que cuando se utilice esta propiedad, el self esté inicializado
    private lazy var avatarImage: UIImageView = {
        let avatar = UIImageView(image: UIImage(named:"EmptyProfile.png"))
        avatar.contentMode = .scaleAspectFit
        avatar.layer.masksToBounds = true
        // Circle Shape
        avatar.layer.cornerRadius = (self.view.bounds.width / 4) / 2
        // Para utilizar las constraints por codigo
        avatar.translatesAutoresizingMaskIntoConstraints = false
        return avatar
    }()
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = ""
        label.textColor = .systemBlue
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 26)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = ""
        label.textColor = .systemCyan
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 6
        label.textAlignment = .natural
        label.text = ""
        label.textColor = .black
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var reposButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.titleAlignment = .center
        configuration.subtitle = "Muestra los repos del perfil seleccionado"
        configuration.imagePadding = 12
        configuration.cornerStyle = .capsule
        let buttonAction = UIAction { _ in
            self.performSegue(withIdentifier: "SegueToRepoListView", sender: self)
        }
        let button = UIButton(type: .system, primaryAction: buttonAction)
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .systemPurple
        view.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - DidLoad Function
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        getUserAndSetData()
        setAllConstraints()
    }
    
    // MARK: - Private functions
    private func addSubViews() {
        [avatarImage, usernameLabel, nameLabel, bioLabel, reposButton, indicatorView].forEach(view.addSubview)
    }
    
    private func getUserAndSetData() {
        Task {
            let result = await vm.getUser(user: username)
            switch result {
            case .success (let user):
                DispatchQueue.main.async {
                    self.user = user
                    self.indicatorView.stopAnimating()
                    self.setData()
                }
            case .failure (let error):
                print(error)
            }
        }
    }
    
    //Set data debe ser después de obtener los datos
    private func setData() {
        // Image
        if let imageString = user?.avatarURL {
            if let imageURL = URL(string: imageString) {
                avatarImage.load(url: imageURL)
            }
        }
        // Username
        if let username = user?.username {
            usernameLabel.text = username
        }
        // Name
        if let name = user?.name {
            nameLabel.text = name
        }
        // Bio
        if let bio = user?.bio {
            bioLabel.text = bio
        }
        // Button
        if let username = user?.username {
            reposButton.configuration?.title = "Repos de \(username)"
        }
    }
    
    // MARK: - Constraints
    private func setAllConstraints() {
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 30),
            avatarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImage.heightAnchor.constraint(equalToConstant: view.bounds.width / 4),
            avatarImage.widthAnchor.constraint(equalToConstant: view.bounds.width / 4),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 30),
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            nameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 30),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -30),
            
            bioLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            bioLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            reposButton.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 30),
            reposButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToRepoListView" {
            if let username = user?.username {
                guard let image = avatarImage.image else { return }
                if let destinationViewController = segue.destination as? RepoListView {
                    destinationViewController.username = username
                    destinationViewController.image = image
                }
            }
        }
    }
    
}
