//
//  MainTodoViewController+Actions.swift
//  DoGit
//
//  Created by neuli on 2022/04/15.
//

import UIKit

extension MainTodoViewController {
 
    @objc func touchUpInsideAddButton(_ sender: UIButton) {
        let addRepositoryViewController = AddRepositoryViewController()
        let navigationController = UINavigationController(rootViewController: addRepositoryViewController)
        self.present(navigationController, animated: true)
    }

    @objc func touchUpInsideDoneButton(_ sender: TodoDoneButton) {
        print(#function)
        guard let todoID = sender.todo?.id else { return }
        guard let todo = realm.objects(Todo.self).filter({ $0.id == todoID }).first else { return }
        try! realm.write {
            todo.isDone.toggle()
        }
        updateSnapshot(with: [todoID])
    }
    
    func showBottomSheet(repository: Repository) {
        let writeTodoViewController = WriteTodoViewController(repository: repository)
        
        let bottomSheetViewController = BottomSheetViewController(contentViewController: writeTodoViewController)
        bottomSheetViewController.modalPresentationStyle = .overFullScreen
        self.present(bottomSheetViewController, animated: false)
    }
}
