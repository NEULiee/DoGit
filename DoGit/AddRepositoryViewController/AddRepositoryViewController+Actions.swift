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
            // alert 창
            // yes -> realm 삭제 후 checkRepositoriesID 다시 읽어와서 updateSanpshot()
            // no -> x
        } else {
            // realm 추가 후 checkRepositoriesID 다시 읽어와서 updateSanpshot()
            createRepository(with: repository)
            getCheckedRepositoryID()
            checkedRepositories = githubRepositories.filter { checkedRepositoriesId.contains($0.id) }
            performQuery(with: searchBar.text)
        }
    }
    
    @objc func didSaveRepository(_ sender: UIBarButtonItem) {
        
    }
}
