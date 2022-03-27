//
//  GitService.swift
//  StarGit
//
//  Created by David Vicente on 27/3/22.
//

import Foundation

protocol GitService {
    func getGitUser(user: String) async throws -> UserModel
    func getGitUsersList(text: String) async throws -> [UserModel]
}

final class GitServiceImpl: GitService {
    
    func getGitUser(user: String) async throws -> UserModel {
        let urlSession = URLSession.shared
        let url = URL(string: APIConstants.baseURL.appending(user))
        let (data, _) = try await urlSession.data(from: url!)
        return try JSONDecoder().decode(UserModel.self, from: data)
    }
    
    // BETA
    func getGitUsersList(text: String) async throws -> [UserModel] {
        let urlSession = URLSession.shared
//        let url = URL(string: APIConstants.baseURL.appending(text))
        let url = URL(string: APIConstants.baseURL.appending(text))
        let (data, _) = try await urlSession.data(from: url!)
        return try JSONDecoder().decode([UserModel].self, from: data)
    }
    
    func getGitUserRepoList(user: String) async throws -> [RepoModel] {
        let urlSession = URLSession.shared
        let url = URL(string: APIConstants.baseURL.appending(user + APIConstants.repoURL))
        let (data, _) = try await urlSession.data(from: url!)
        return try JSONDecoder().decode([RepoModel].self, from: data)
    }
    
}
