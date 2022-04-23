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
    
    func showBottomSheet(repository: Repository) {
        let writeTodoViewController = WriteTodoViewController(repository: repository)
        
        let bottomSheetViewController = BottomSheetViewController(contentViewController: writeTodoViewController)
        bottomSheetViewController.modalPresentationStyle = .overFullScreen
        self.present(bottomSheetViewController, animated: false)
    }
}
