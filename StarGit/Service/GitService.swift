//
//  GitService.swift
//  StarGit
//
//  Created by David Vicente on 27/3/22.
//

import Foundation

protocol GitService {
    func getGitUser(user: String) async throws -> UserModel
    func getGitUsersList(text: String) async throws -> UserListModel
    func getGitUserReposList(user: String) async throws -> [RepoModel]
}

final class GitServiceImpl: GitService {
    
    func getGitUser(user: String) async throws -> UserModel {
        let urlSession = URLSession.shared
        guard !user.isEmpty else {
            throw URLErrors.emptyUser
        }
        guard let url = URL(string: APIConstants.usersURL.appending(user)) else {
            throw URLErrors.invalidURL
        }
        do {
            let (data, _) = try await urlSession.data(from: url)
            return try JSONDecoder().decode(UserModel.self, from: data)
        }
        catch {
            throw APIErrors.getUser
        }
    }
    
    func getGitUsersList(text: String) async throws -> UserListModel {
        let urlSession = URLSession.shared
        guard !text.isEmpty else {
            throw URLErrors.emptyUser
        }
        guard let url = URL(string: APIConstants.searchUsersURL.appending(text + APIConstants.queryUsername + APIConstants.queryResults)) else {
            throw URLErrors.invalidURL
        }
        do {
            let (data, _) = try await urlSession.data(from: url)
            return try JSONDecoder().decode(UserListModel.self, from: data)
        } catch {
            throw  APIErrors.getUsersList
        }
    }
    
    func getGitUserReposList(user: String) async throws -> [RepoModel] {
        let urlSession = URLSession.shared
        guard !user.isEmpty else {
            throw URLErrors.emptyUser
        }
        guard let url = URL(string: APIConstants.usersURL.appending(user + APIConstants.repoDIR)) else {
            throw URLErrors.invalidURL
        }
        do {
            let (data, _) = try await urlSession.data(from: url)
            return try JSONDecoder().decode([RepoModel].self, from: data)
        }
        catch {
            throw APIErrors.getUserReposList
        }
    }
    
}
