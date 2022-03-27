//
//  RepoModel.swift
//  StarGit
//
//  Created by David Vicente on 27/3/22.
//

import Foundation

struct RepoModel: Codable {
    
    var name: String
    var fullName: String
    var repoURL: String
    var language: String
    var description: String?
    var owner: UserModel
    
    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
        case repoURL = "html_url"
        case language
        case description
        case owner
    }
    
}
