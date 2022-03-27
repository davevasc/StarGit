//
//  Constants.swift
//  StarGit
//
//  Created by David Vicente on 27/3/22.
//

import Foundation

enum APIConstants {
    static let baseURL = "https://api.github.com"
    static let usersURL = APIConstants.baseURL + "/users/"
    static let searchUsersURL = APIConstants.baseURL + "/search/users?q="
    static let repoDIR = "/repos"
    static let queryUsername = "+in:login"
    static let queryResults = "&per_page=" + String(APIConstants.maxResults)
    static let maxResults = 5
    
    
//    static let x = "https://api.github.com/search/users?q=dave+in:login&per_page=2"
   
}
