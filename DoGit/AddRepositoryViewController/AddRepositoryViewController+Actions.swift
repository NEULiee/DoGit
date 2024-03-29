//
//  AddRepositoryViewController+Actions.swift
//  DoGit
//
//  Created by neuli on 2022/04/16.
//

import UIKit

extension AddRepositoryViewController {
    @objc func didCancelAdd(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @objc func didSelectRepository(_ sender: UIButton) {
        guard let repositoryCheckButton = sender as? RepositoryCheckButton else { return }
        guard let repositoryID = repositoryCheckButton.repositoryID else { return }
        let index = GithubRepositoryStore.shared.githubRepositories.indexOfGithubRepository(with: repositoryID)
        let githubRepository = GithubRepositoryStore.shared.githubRepository(for: repositoryID)
        
        if GithubRepositoryStore.shared.checkedRepositoriesID.contains(repositoryID) {
            showRepositoryTodoDeleteCheckAlert(index, githubRepository)
        } else {
            DoGitStore.shared.createRepository(with: githubRepository)
            GithubRepositoryStore.shared.githubRepositoryIsCheckToggle(index: index)
            GithubRepositoryStore.shared.setCheckedRepositoriesID()
            updateSnapshot(with: [githubRepository])
            showToastMessageLabel()
            HapticNotificationManager.occur(notificationType: .success)
        }
    }
}
