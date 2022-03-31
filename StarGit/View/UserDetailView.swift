//
//  UserDetailView.swift
//  StarGit
//
//  Created by David Vicente on 30/3/22.
//

import UIKit

class UserDetailView: UIViewController {
    
    var user: UserModel?
    private let vm = GitViewModel()
    
    @IBOutlet weak var showReposButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .red
        
        title = "User Detail"
        
        showReposButton.configuration?.baseForegroundColor = .yellow
        showReposButton.configuration?.image = UIImage(systemName: "magnifyingglass.circle.fill")
        if let username = user?.username {
            showReposButton.setTitle("Muestra Repos de \(username)", for: .normal)
        } else {
            showReposButton.setTitle("Muestra Repos", for: .normal)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
