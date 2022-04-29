//
//  GithubRepositoryStore.swift
//  DoGit
//
//  Created by neuli on 2022/04/29.
//

import Foundation

class GithubRepositoryStore {
    
    static let shared = GithubRepositoryStore()
    
    private let githubDataManager = GithubDataManager()
    
    var githubRepositories: [GithubRepository] = []
    var checkedRepositoriesID: [Int64] = []
    
    func githubRepositoryIsCheckToggle(index: Int) {
        GithubRepositoryStore.shared.githubRepositories[index].isCheck.toggle()
    }
    
    func githubRepository(for id: GithubRepository.ID) -> GithubRepository {
        
        let index = GithubRepositoryStore.shared.githubRepositories.indexOfGithubRepository(with: id)
        return githubRepositories[index]
    }
    
    func setCheckedRepositoriesID() {
        GithubRepositoryStore.shared.checkedRepositoriesID = DoGitStore.shared.readRepositoryIDAll()
    }
    
    private init() {}
}
