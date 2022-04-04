//
//  UserCell.swift
//  StarGit
//
//  Created by David Vicente on 30/3/22.
//

//import UIKit
//
//class UserCell: UITableViewCell {
//
//    // MARK: - Cell String Identifier
//    static let identifier = "UserCell"
//
//    // MARK: - UI Elements
//    var avatarImage: UIImageView = {
//        let avatar = UIImageView(image: UIImage(named:"EmptyProfile.png"))
//        avatar.contentMode = .scaleAspectFit
//        avatar.layer.masksToBounds = true
//        // Radius Shape
//        avatar.layer.cornerRadius = 10
//        // Para utilizar las constraints por codigo
//        avatar.translatesAutoresizingMaskIntoConstraints = false
//        return avatar
//    }()
//    /** Updated 03-04-2022 */
//    var nameLabel: UILabel = { // lazy
//        let label = UILabel()
//        label.numberOfLines = 1
//        label.textAlignment = .natural
//        label.text = ""
//        label.font = UIFont(name: "Arial Rounded MT Bold", size: 22)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    private lazy var stack: UIStackView = {
//        let stk = UIStackView(arrangedSubviews: [self.avatarImage, self.nameLabel])
//        stk.translatesAutoresizingMaskIntoConstraints = false
//        stk.axis = .horizontal
//        stk.spacing = 20
//        return stk
//    }()
//
//    // MARK: - Configure Cell Data
//    func configure(Avatar avatarURL: String, Username username: String, TextColor textColor: UIColor, BackgroundColor backgroundColor: UIColor) {
//        // Image
//        if let url = URL(string: avatarURL) {
//            self.avatarImage.load(url: url)
//        } else {
//            self.avatarImage.image = UIImage(named:"EmptyProfile.png")
//        }
//        // Text
//        self.nameLabel.text = username
//        // Colors
//        self.nameLabel.textColor = textColor
//        self.backgroundColor = backgroundColor.soft()
//    }
//
//    /** Updated 03-04-2022 */
//    override func updateConfiguration(using state: UICellConfigurationState) {
//        super.updateConfiguration(using: state)
//
//        var contentConfig = defaultContentConfiguration().updated(for: state)
//        contentConfig.text = "Hello World"
//        contentConfig.image = UIImage(systemName: "bell")
//
//        var backgroundConfig = backgroundConfiguration?.updated(for: state)
//        backgroundConfig?.backgroundColor = .purple
//
//        contentConfiguration = contentConfig
//        backgroundConfiguration = backgroundConfig
//    }
//
//
//    // MARK: - Initialization
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.addSubview(self.stack)
//        self.setAllConstraints()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // MARK: - Prepare function
//    override func prepareForReuse() {
//        self.avatarImage.image = UIImage(named:"EmptyProfile.png")
//        self.nameLabel.text = ""
//        self.backgroundColor = nil
//    }
//
//    // MARK: - Constraints
//    private func setAllConstraints() {
//        NSLayoutConstraint.activate([
//            avatarImage.heightAnchor.constraint(equalToConstant: bounds.width / 10),
//            avatarImage.widthAnchor.constraint(equalToConstant: bounds.width / 10),
//
//            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
//            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
//            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
//        ])
//    }
//
//}
