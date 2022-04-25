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
        
        if todo == nil { // 할일 추가
            guard let text = contentTextField.text else { return }
            let todo = Todo(content: text)
            let repositoryID = repository.id
            guard let realmRepository = realm.objects(Repository.self).filter({ $0.id == repositoryID }).first else { return }
            
            try! realm.write {
                realmRepository.todos.append(todo)
            }
        } else { // 할일 수정
            guard let text = contentTextField.text else { return }
            
            try! realm.write {
                todo.content = text
            }
        }
    }
}
