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
        userDataManager.fetchUser(userId: name) { result in
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
    
    func showAlert(message errorDescription: String) {
        let alert = UIAlertController(title: "", message: errorDescription, preferredStyle: .alert)
        alert.view.accessibilityIdentifier = "nameAlert"
        alert.view.tintColor = .mainColor
        alert.addAction(UIAlertAction(title: "다시입력", style: .default, handler: { [weak self] _ in
            self?.dismiss(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
}
