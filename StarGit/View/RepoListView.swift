//
//  RepoListView.swift
//  StarGit
//
//  Created by David Vicente on 31/3/22.
//

import UIKit

class RepoListView: UIViewController {
    
    // MARK: - External vars
    var username: String = ""
    var image: UIImage = UIImage()
    
    // MARK: - Internal vars
    private var repos: [RepoModel] = []
    private let vm = GitViewModel()
    
    // MARK: - UI Elements
    //Lazy Var para que cuando se utilice esta propiedad, el self esté inicializado
    private lazy var avatarImage: UIImageView = {
        let avatar = UIImageView(image: self.image)
        avatar.contentMode = .scaleAspectFit
        avatar.layer.masksToBounds = true
        // Circle Shape
        avatar.layer.cornerRadius = (self.view.bounds.width / 8) / 2
        // Para utilizar las constraints por codigo
        avatar.translatesAutoresizingMaskIntoConstraints = false
        return avatar
    }()
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .natural
        label.text = self.username
        label.textColor = .systemBlue
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 26)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    /** Updated 03-04-2022 */
    private var reposLabel: UILabel = { // lazy
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .natural
        label.text = "Repos:"
        label.textColor = .black
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(RepoCell.self, forCellReuseIdentifier: RepoCell.identifier)
        table.layer.cornerRadius = 12
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    /** Updated 03-04-2022 */
    private var indicatorView: UIActivityIndicatorView = { // lazy
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
        getReposAndReloadData()
        setAllConstraints()
    }
    
    // MARK: - Private functions
    private func addSubViews() {
        [avatarImage, usernameLabel, reposLabel, tableView, indicatorView].forEach(view.addSubview)
    }
    
    private func getReposAndReloadData() {
        Task {
            let result = await vm.getUserReposList(user: self.username)
            switch result {
            case .success (let repos):
                self.repos = repos
                DispatchQueue.main.async {
                    self.indicatorView.stopAnimating()
                    self.tableView.reloadData()
                }
            case .failure (let error):
                /** Updated 03-04-2022 */
                print(error.localizedDescription) // print(error)
            }
        }
    }
    
    // MARK: - Constraints
    private func setAllConstraints() {
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 30),
            avatarImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            avatarImage.heightAnchor.constraint(equalToConstant: view.bounds.width / 8),
            avatarImage.widthAnchor.constraint(equalToConstant: view.bounds.width / 8),
            
            usernameLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 30),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            usernameLabel.heightAnchor.constraint(equalToConstant: view.bounds.width / 8),
            
            reposLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 30),
            reposLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            reposLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -30),
            
            tableView.topAnchor.constraint(equalTo: reposLabel.bottomAnchor, constant: 30),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}

// MARK: - TableView functions
extension RepoListView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.identifier, for: indexPath) as? RepoCell else {
            fatalError("\(RepoCell.identifier) is not available")
        }
        let repo = repos[indexPath.row]
        cell.configure(Name: repo.name, FullName: repo.fullName, RepoURL: repo.repoURL, Language: repo.language ?? "", Description: repo.description ?? "", NameColor: .systemBlue, FullNameColor: .systemCyan, BackgroundColor: .systemTeal)
        return cell
    }
    
}
