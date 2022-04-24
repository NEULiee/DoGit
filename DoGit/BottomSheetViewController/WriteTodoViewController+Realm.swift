//
//  WriteTodoViewController+Realm.swift
//  DoGit
//
//  Created by neuli on 2022/04/23.
//

import UIKit

extension WriteTodoViewController {
    func updateTodo() {
        guard let text = contentTextField.text else { return }
        let todo = Todo(content: text)
        let repositoryID = repository.id
        guard let realmRepository = realm.objects(Repository.self).filter({ $0.id == repositoryID }).first else { return }
        
        try! realm.write {
            realmRepository.todos.append(todo)
        }
    }
}
