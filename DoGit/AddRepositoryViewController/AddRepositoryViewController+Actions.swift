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
        let index = githubRepositories.indexOfGithubRepository(with: repositoryID)
        let repository = githubRepositories[index]
        
        if checkedRepositoriesId.contains(repositoryID) {
            showRepositoryTodoDeleteCheckAlert(index, repository)
        } else {
            createRepository(with: repository)
            githubRepositories[index].isCheck.toggle()
            getCheckRepositories()
            updateSnapshot(with: [repository])
        }
    }
}
