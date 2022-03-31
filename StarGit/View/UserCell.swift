//
//  UserCell.swift
//  StarGit
//
//  Created by David Vicente on 30/3/22.
//

import UIKit

class UserCell: UITableViewCell {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    func configure(Avatar avatarURL: String, Username username: String, TextColor textColor: UIColor, BackgroundColor backgroundColor: UIColor) {
        //Image
        if let url = URL(string: avatarURL) {
            self.avatarImage.load(url: url)
        } else {
            self.avatarImage.image = UIImage(named:"EmptyProfile.png")
        }
        // Text
        self.usernameLabel.text = username
        self.usernameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        // Colors
        self.usernameLabel.textColor = textColor
        self.backgroundColor = backgroundColor.soft()
    }
    
    override func prepareForReuse() {
        self.avatarImage.image = UIImage(named:"EmptyProfile.png")
        self.usernameLabel.text = ""
        self.backgroundColor = nil
    }
}
