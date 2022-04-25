//
//  AddRepositoryViewController+Realm.swift
//  DoGit
//
//  Created by neuli on 2022/04/22.
//

import UIKit

extension AddRepositoryViewController {
    
    func createRepository(with repository: GithubRepository) {
        let todo: Todo = Todo(content: "왼쪽으로 스와이프 시 삭제할 수 있습니다.")
        let repository: Repository = Repository(id: repository.id, name: repository.name)
        try! realm.write {
            realm.add(repository)
            repository.todos.append(todo)
        }
    }
    
    func deleteRepository(with index: Int) {
        if let savedRepository = realm.objects(Repository.self).filter({ $0.id == self.githubRepositories[index].id }).first {
            try! realm.write {
                realm.delete(savedRepository.todos)
                realm.delete(savedRepository)
            }
        }
    }
}
