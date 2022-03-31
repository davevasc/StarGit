//
//  ViewController.swift
//  StarGit
//
//  Created by David Vicente on 27/3/22.
//

import UIKit

class UserListView: UIViewController {
    
    

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    private let vm = GitViewModel()
    private var users: [UserModel] = []
    
    
//    private var vm: GitViewModel
    
    
//    init(vm: GitViewModel = GitViewModel()) {
//        self.vm = vm
//        //self.userListModel = UserListModel()
//    }

//    init() {
//        self.userListModel = UserListModel()
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup table
        tableView.estimatedRowHeight = 30
        tableView.rowHeight = UITableView.automaticDimension
        
        
        labelName.textColor = .blue
        
        
        //Button
        searchButton.configuration?.baseForegroundColor = .systemBlue
        searchButton.configuration?.image = UIImage(systemName: "magnifyingglass.circle.fill")
//        searchButton.setTitle("Busca Usuarios!", for: .normal)
        
    }
    
//    // ejecuta antes de que la vista aparezca
//    override func viewWillAppear(_ animated: Bool) {
//        <#code#>
//    }
//
//    // ejecuta antes de que la vista desaparezca
//    override func viewWillDisappear(_ animated: Bool) {
//        <#code#>
//    }
    
    
    @IBAction func didTapOn(_ sender: Any) {
        
        self.tableView.dataSource = self
        self.tableView.layer.cornerRadius = 10

        
        Task {
            let result = await vm.getUsersList(text: textField.text ?? "")
            switch result {
            case .success (let users):
                self.users = users
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure (let error):
                print(error)
            }
        }
        
        
    }
    
    
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToUserDetailView" {
            if let row = tableView.indexPathForSelectedRow?.row {
                let user = users[row]
                
                if let destinationViewController = segue.destination as? UserDetailView {
                    destinationViewController.user = user
                }
            }
        }
    }
    
   

    

}

extension UserListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell else {
            fatalError("UserCell is not available")
        }
        let user = users[indexPath.row]
        cell.configure(Avatar: user.avatarURL, Username: user.username, TextColor: .systemBlue, BackgroundColor: .gray)
        return cell
    }
    
    
}

