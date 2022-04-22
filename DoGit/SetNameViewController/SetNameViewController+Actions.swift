//
//  SetNameViewController+Actions.swift
//  DoGit
//
//  Created by neuli on 2022/04/08.
//

import UIKit

extension SetNameViewController {
    
    @objc func didPressDoneButton(_ sender: UIButton)  {
        guard let name = self.nameTextField.text else { return }
        githubDataManager.fetchUser(userId: name) { result in
            switch result {
            case .success:
                DispatchQueue.main.sync {
                    self.dismiss(animated: true)
                }
            case .failure(let error):
                self.hapticNotification.notificationOccurred(.error)
                DispatchQueue.main.sync {
                    self.showAlert(message: error.localizedDescription)
                }
            }
        }
    }
}
