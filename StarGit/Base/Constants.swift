//
//  Constants.swift
//  StarGit
//
//  Created by David Vicente on 27/3/22.
//

import Foundation

// MARK: - API static constants
enum APIConstants {
    static let baseURL = "https://api.github.com"
    static let usersURL = APIConstants.baseURL + "/users/"
    static let searchUsersURL = APIConstants.baseURL + "/search/users?q="
    static let repoDIR = "/repos"
    static let queryUsername = "+in:login"
    static let queryResults = "&per_page=" + String(APIConstants.maxResults)
    static let maxResults = 10
}

// MARK: - Custom Errors
enum URLErrors: String, Error {
    case invalidURL = "Error processing URL"
    case emptyUser = "Empty User for search"
}

// MARK: - Git API Errors
enum APIErrors: String, Error {
    case getUser = "Error getting user from API"
    case getUsersList = "Error getting users list from API"
    case getUserReposList = "Error getting user repos list from API"
}
