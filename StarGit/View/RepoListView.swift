//
//  RepoListView.swift
//  StarGit
//
//  Created by David Vicente on 31/3/22.
//

import UIKit

class RepoListView: UIViewController {

    var user: UserModel?
    var repos: [RepoModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .yellow
        title = "User Repos"
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
