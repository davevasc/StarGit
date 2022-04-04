//
//  Constants.swift
//  StarGit
//
//  Created by David Vicente on 27/3/22.
//

import Foundation

// MARK: - API static constants
/** Updated 03-04-2022 */
struct APIConstants { // enum APIConstants {
    static let baseURL = "https://api.github.com"
    static let usersURL = APIConstants.baseURL + "/users/"
    static let searchUsersURL = APIConstants.baseURL + "/search/users?q="
    static let repoDIR = "/repos"
    static let queryUsername = "+in:login"
    static let queryResults = "&per_page=" + String(APIConstants.maxResults)
    static let maxResults = 10
}

// MARK: - Custom Errors
/** Updated 03-04-2022 */
enum URLErrors: Error { // enum URLErrors: String, Error {
    case invalidURL     // = "Error processing URL"
    case emptyUser      // = "Empty User for search"
}
extension URLErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL: return "Error processing URL"
        case .emptyUser: return "Empty User for search"
        }
    }
}

// MARK: - Custom Git API Errors
/** Updated 03-04-2022 */
enum APIErrors: Error {     // enum URLErrors: String, Error {
    case getUser            // = "Error getting user from API"
    case getUsersList       // = "Error getting users list from API"
    case getUserReposList   // = "Error getting user repos list from API"
}
extension APIErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .getUser: return "Error getting user from API"
        case .getUsersList: return "Error getting users list from API"
        case .getUserReposList: return "Error getting user repos list from API"
        }
    }
}
