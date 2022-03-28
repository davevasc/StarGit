//
//  GitViewModel.swift
//  StarGit
//
//  Created by David Vicente on 28/3/22.
//

import Foundation

final class GitViewModel {
    
    private let service: GitService
    
    init(service: GitService = GitServiceImpl()) {
        self.service = service
    }
    
    func getUser(user: String) async -> Result<UserModel, Error> {
        do {
            let user = try await self.service.getGitUser(user: user)
            return .success(user)
        }
        catch {
            return .failure(error)
        }
    }
    
    func getUsersList(text: String) async -> Result<[UserModel], Error> {
        do {
            let usersList = try await self.service.getGitUsersList(text: text)
            return .success(usersList.users)
        }
        catch {
            return .failure(error)
        }
    }
    
    func getUserReposList(user: String) async -> Result<[RepoModel], Error> {
        do {
            let userReposList = try await self.service.getGitUserReposList(user: user)
            return .success(userReposList)
        }
        catch {
            return .failure(error)
        }
    }
    
}
