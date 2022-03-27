//
//  ViewController.swift
//  StarGit
//
//  Created by David Vicente on 27/3/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var suscribeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelName.textColor = .blue
        suscribeButton.setTitle("Nuevo Titulo ya!", for: .normal)

        
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
    

}

