//
//  WriteTodoViewController+Actions.swift
//  DoGit
//
//  Created by neuli on 2022/04/21.
//

import UIKit

extension WriteTodoViewController {
    
    @objc func doneButtonTapped() {
        print(#function)
        
        guard let text = contentTextField.text else { return }
        let todo = Todo(content: text)
        let repositoryID = repository.id
        guard let realmRepository = realm.objects(Repository.self).filter({ $0.id == repositoryID }).first else { return }
        
        try! realm.write {
            realmRepository.todos.append(todo)
        }
    }
}
