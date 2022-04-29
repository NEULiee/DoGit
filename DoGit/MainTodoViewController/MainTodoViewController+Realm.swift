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
                    self?.makeSnapshot()
                    self?.checkRepositoriesIsEmpty()
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
            case .update(let todos, let deletions, let insertions, let modification):
                DoGitStore.shared.readAll()
                if 0 < deletions.count || 0 < insertions.count {
                    self?.makeSnapshot()
                } else if 0 < modification.count {
                    self?.updateSnapshot(with: [todos[modification[0]].id])
                }
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    func userNotification() {
        
        realmUsers = realm.objects(User.self)
        userNotificationToken = realmUsers.observe { [weak self] changes in
            switch changes {
            case .initial:
                break
            case .update(_, _, let insertions, _):
                if 0 < insertions.count {
                    DoGitStore.shared.readCurrentUser()
                    self?.setUserNameAfterChangeName()
                }
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
}
