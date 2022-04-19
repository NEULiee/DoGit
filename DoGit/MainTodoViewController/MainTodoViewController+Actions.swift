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

    @objc func touchUpInsideDoneButton(_ sender: UIButton) {
        
    }
    
    func addTodo(repository: Repository) {
        // 투두 추가하는 함수
        
        let bottomSheetViewController = BottomSheetViewController(contentViewController: UIViewController())
        bottomSheetViewController.modalPresentationStyle = .overFullScreen
        self.present(bottomSheetViewController, animated: false)
    }
}
