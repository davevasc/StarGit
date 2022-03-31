//
//  RepoCell.swift
//  StarGit
//
//  Created by David Vicente on 30/3/22.
//

import UIKit

class RepoCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var repoUrlLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(Name name: String, FullName fullName: String, RepoURL repoURL: String, Language language: String, Description description: String, NameColor nameColor: UIColor, FullNameColor fullNameColor: UIColor, BackgroundColor backgroundColor: UIColor) {
        // Texts
        nameLabel.text = name
        fullNameLabel.text = fullName
        repoUrlLabel.text = repoURL
        languageLabel.text = language
        descriptionLabel.text = description
        // Colors
        nameLabel.textColor = nameColor
        fullNameLabel.textColor = fullNameColor
        repoUrlLabel.textColor  = .link
        languageLabel.textColor = .red
        descriptionLabel.textColor = .gray
        self.backgroundColor = backgroundColor
    }
    
    override func prepareForReuse() {
        nameLabel.text = ""
        fullNameLabel.text = ""
        repoUrlLabel.text = ""
        languageLabel.text = ""
        descriptionLabel.text = ""
        self.backgroundColor = nil
    }
}
