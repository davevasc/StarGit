//
//  ViewController.swift
//  StarGit
//
//  Created by David Vicente on 27/3/22.
//

import UIKit

class UserListView: UIViewController {
    
    // MARK: - Internal vars
    private var users: [UserModel] = []
    private let vm = GitViewModel()
    
    // MARK: - UI Elements
    /** Updated 03-04-2022 */
    private var logoLabel: UILabel = { // lazy
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "⭐️ StarGit ⭐️"
        label.textColor = .systemPurple
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    /** Updated 03-04-2022 */
    private var searchField: UITextField = { // lazy
        let field = UITextField()
        field.textAlignment = .natural
        field.text = ""
        field.placeholder = "Búsqueda de usuario..."
        field.textColor = .black
        field.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        field.backgroundColor = .systemCyan.soft()
        field.layer.cornerRadius = 10
        field.layer.shadowRadius = 20
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    private lazy var searchButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "magnifyingglass.circle",
          withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        configuration.cornerStyle = .capsule
        configuration.imagePadding = 12
        /** Updated 03-04-2022 */
        let buttonAction = UIAction { [weak self] _ in  // let buttonAction = UIAction { _ in
            self?.getUsersAndReloadData()               // self?.getUsersAndReloadData()
        }
        let button = UIButton(type: .system, primaryAction: buttonAction)
        button.configuration = configuration
        // Para utilizar las constraints por codigo
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        /** Updated 03-04-2022 */
        table.register(UITableViewCell.self, forCellReuseIdentifier: "UserCell")
//        table.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        table.layer.cornerRadius = 12
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    /** Updated 03-04-2022 */
    private var indicatorView: UIActivityIndicatorView = { // lazy
        let view = UIActivityIndicatorView(style: .large)
        view.color = .systemPurple
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - DidLoad Function
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setAllConstraints()
    }
    
    // MARK: - Private functions
    private func addSubViews() {
        [logoLabel, searchField, searchButton, tableView, indicatorView].forEach(view.addSubview)
    }
    
    private func getUsersAndReloadData() {
        Task {
            indicatorView.startAnimating()
            guard searchField.text != "" else {
                self.indicatorView.stopAnimating()
                /** Updated 03-04-2022 */
                self.show(Title: "Alerta", Message: "Introduce un texto")
                //Utils.show(Message: "Introduce un texto", WithTitle: "Alerta", InViewController: self)
                return
            }
            if let text = searchField.text?.replacingOccurrences(of: " ", with: "") {
                let result = await vm.getUsersList(text: text)
                switch result {
                case .success (let users):
                    self.users = users
                    if self.users.isEmpty {
                        self.indicatorView.stopAnimating()
                        /** Updated 03-04-2022 */
                        self.show(Title: "Alerta", Message: "Sin resultados")
                        //Utils.show(Message: "Sin resultados", WithTitle: "Alerta", InViewController: self)
                    } else {
                        DispatchQueue.main.async {
                            self.indicatorView.stopAnimating()
                            self.tableView.reloadData()
                        }
                    }
                case .failure (let error):
                    /** Updated 03-04-2022 */
                    print(error.localizedDescription) // print(error)
                }
            }
        }
    }
    
    // MARK: - Constraints
    private func setAllConstraints() {
        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 30),
            logoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            logoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            searchButton.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 30),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            searchButton.heightAnchor.constraint(equalToConstant: view.bounds.width / 10),
            searchButton.widthAnchor.constraint(equalToConstant: view.bounds.width / 10),
            
            searchField.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 30),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            searchField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -30),
            searchField.heightAnchor.constraint(equalToConstant: view.bounds.width / 10),
            
            tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 30),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - TableView functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToUserDetailView" {
            if let row = tableView.indexPathForSelectedRow?.row {
                let username = users[row].username
                if let destinationViewController = segue.destination as? UserDetailView {
                    destinationViewController.username = username
                }
            }
        }
    }
    
}

// MARK: - TableView functions
extension UserListView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /** Updated 03-04-2022 */
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as UITableViewCell? else {
            fatalError("UserCell is not available")
        }
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as? UserCell else {
//            fatalError("\(UserCell.identifier) is not available")
//        }
        
        // Obtenemos los datos de la celda
        let user = users[indexPath.row]
        
        /** Updated 03-04-2022 */
        // Content
        var content = cell.defaultContentConfiguration()
        content.text = user.username
        content.textProperties.color = .systemBlue
        if let font = UIFont(name: "Arial Rounded MT Bold", size: 22) {
            content.textProperties.font = font
        }
        let image = UIImageView()
        image.image = UIImage(named:"EmptyProfile.png")
        if let url = URL(string: user.avatarURL) {
            image.load(url: url)
        }
        content.image = image.image
        content.imageProperties.cornerRadius = 10
        content.imageProperties.maximumSize = CGSize(width: Int(view.bounds.width / 10), height: Int(view.bounds.width / 10))
        cell.contentConfiguration = content
        
        /** Updated 03-04-2022 */
        // Background
        var background = cell.backgroundConfiguration
        background?.backgroundColor = .systemTeal.soft()
        cell.backgroundConfiguration = background
        
//        cell.configure(Avatar: user.avatarURL, Username: user.username, TextColor: .systemBlue, BackgroundColor: .systemTeal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "SegueToUserDetailView", sender: self)
    }
    
}

