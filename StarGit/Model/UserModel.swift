//
//  UserModel.swift
//  StarGit
//
//  Created by David Vicente on 27/3/22.
//

import Foundation

struct UserModel: Codable {
    
    var avatarURL: String
    var username: String
    var name: String?
    var bio: String?
    var reposURL: String
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case username = "login"
        case name
        case bio
        case reposURL = "repos_url"
    }
    
    init(avatarURL: String, username: String, reposURL: String) {
        self.avatarURL = avatarURL
        self.username = username
        self.name = nil
        self.bio = nil
        self.reposURL = reposURL
    }
    
}

struct UserListModel: Codable {
    var users: [UserModel]
    
    enum CodingKeys: String, CodingKey {
        case users = "items"
    }
    
    init() {
        self.users = []
    }
    
}
    
    

