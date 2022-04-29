//
//  WriteTodoViewController+Actions.swift
//  DoGit
//
//  Created by neuli on 2022/04/21.
//

import UIKit

extension WriteTodoViewController {
    
    @objc func doneButtonTapped() {
        
        if todo == nil { // 할일 추가
            guard let text = contentTextField.text else { return }
            let todo = Todo(content: text)
            let repositoryID = repository.id
            let repository = DoGitStore.shared.repository(with: repositoryID)
            DoGitStore.shared.appendTodoInRepository(repository: repository, todo: todo)
        } else { // 할일 수정
            guard let text = contentTextField.text else { return }
            DoGitStore.shared.updateTodo(todo: todo, content: text)
        }
    }
}
