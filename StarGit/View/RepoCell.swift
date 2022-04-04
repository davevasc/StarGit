//
//  RepoCell.swift
//  StarGit
//
//  Created by David Vicente on 30/3/22.
//

import UIKit

class RepoCell: UITableViewCell {
    
    // MARK: - Cell String Identifier
    static let identifier = "RepoCell"
    
    // MARK: - UI Elements
    var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = ""
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var fullNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .natural
        label.text = ""
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var repoUrlLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .natural
        label.text = ""
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var languageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .right
        label.text = ""
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .natural
        label.text = ""
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var stack: UIStackView = {
        let stk = UIStackView(arrangedSubviews: [self.nameLabel, self.fullNameLabel, self.repoUrlLabel, self.languageLabel, descriptionLabel])
        stk.translatesAutoresizingMaskIntoConstraints = false
        stk.axis = .vertical
        return stk
    }()
    
    // MARK: - Configure Cell Data
    func configure(Name name: String, FullName fullName: String, RepoURL repoURL: String, Language language: String, Description description: String, NameColor nameColor: UIColor, FullNameColor fullNameColor: UIColor, BackgroundColor backgroundColor: UIColor) {
        // Texts
        self.nameLabel.text = name
        self.fullNameLabel.text = fullName
        self.repoUrlLabel.text = repoURL
        self.languageLabel.text = language
        self.descriptionLabel.text = description
        // Colors
        self.nameLabel.textColor = nameColor
        self.fullNameLabel.textColor = fullNameColor
        self.repoUrlLabel.textColor  = .link
        self.languageLabel.textColor = .systemPurple
        self.descriptionLabel.textColor = .gray
        self.backgroundColor = backgroundColor.soft()
    }
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(self.stack)
        self.setAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Prepare function
    override func prepareForReuse() {
        self.nameLabel.text = ""
        self.fullNameLabel.text = ""
        self.repoUrlLabel.text = ""
        self.languageLabel.text = ""
        self.descriptionLabel.text = ""
        self.backgroundColor = nil
    }
    
    // MARK: - Constraints
    private func setAllConstraints() {
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
