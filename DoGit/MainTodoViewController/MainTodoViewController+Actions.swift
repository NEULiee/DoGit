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
        let navigationController = UINavigationController(
            rootViewController: addRepositoryViewController
        )
        self.present(navigationController, animated: true)
    }
    
    @objc func touchUpInsideSettingButton(_ sender: UIButton) {
        let settingViewController = SettingViewController()
        let navigationController = UINavigationController(
            rootViewController: settingViewController
        )
        self.present(navigationController, animated: true)
    }

    @objc func touchUpInsideDoneButton(_ sender: TodoDoneButton) {
        guard let todoID = sender.todo?.id else { return }
        DoGitStore.shared.todoIsDoneToggle(with: todoID)
        updateSnapshot(with: [todoID])
        HapticNotificationManager.occur(notificationType: .success)
    }
}
