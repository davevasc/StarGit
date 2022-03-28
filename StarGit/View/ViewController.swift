//
//  ViewController.swift
//  StarGit
//
//  Created by David Vicente on 27/3/22.
//

import UIKit

class ViewController: UIViewController {
    
    
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
        
        Task {
                let result = await vm.getUsersList(text: textField.text ?? "dave")
                switch result {
                case .success (let users):
                    self.users = users
                    print(self.users)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure (let error):
                    print("AAA: ESCRIBIMOS EL ERROR:")
                    print(error)
                }
            }
        
        
    }
    
    
  
    
    
   

    

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.users[indexPath.row].username
        return cell
    }
    
}

