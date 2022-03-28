//
//  ViewController.swift
//  StarGit
//
//  Created by David Vicente on 27/3/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var suscribeButton: UIButton!
    
    
    private var userListModel: UserListModel
    
    
//    private var vm: GitViewModel
    private var vm = GitViewModel()
    
//    init(vm: GitViewModel = GitViewModel()) {
//        self.vm = vm
//        //self.userListModel = UserListModel()
//    }

    init() {
        self.userListModel = UserListModel()
    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelName.textColor = .blue
        suscribeButton.setTitle("Nuevo Titulo ya!", for: .normal)
        
        Task {
            let result = await vm.getUsersList(text: "dave")
            switch result {
            case .success (let userList):
                self.userListModel = userList
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure (let error):
                print(error)
            }
        }
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
        print("se ha suscrito bien!")
    }
    
    
    // En ViewModel
 
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userListModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.userListModel.users[indexPath.row].username
        return cell
    }

    

}

