//
//  MainTodoViewController+Realm.swift
//  DoGit
//
//  Created by neuli on 2022/04/22.
//

import UIKit

extension MainTodoViewController {
    
    func repositoryNotification() {
        realmRepositories = realm.objects(Repository.self)
        repositoryNotificationToken = realmRepositories.observe { [weak self] changes in
            switch changes {
            case .initial:
                break
            case .update(_, let deletions, let insertions, _):
                if 0 < deletions.count || 0 < insertions.count {
                    self?.repositories = TodoRepositoryStore.shared.readTodoAll()
                    self?.updateSnapshot()
                    self?.checkRepositoriesCount()
                }
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    func todoNotification() {
        realmTodos = realm.objects(Todo.self)
        todoNotificationToken = realmTodos.observe { [weak self] changes in
            switch changes {
            case .initial:
                break
            case .update(_, _, let insertions, let deletions):
                if 0 < insertions.count || 0 < deletions.count {
                    self?.updateSnapshot()
                }
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
}
