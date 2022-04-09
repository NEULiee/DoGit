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
                print("success")
            case .failed:
                DispatchQueue.main.sync {
                    self.showAlert()
                }
            }
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "", message: "존재하지 않는 이름이에요.", preferredStyle: .alert)
        alert.view.tintColor = .mainColor
        alert.addAction(UIAlertAction(title: "다시입력", style: .default, handler: { [weak self] _ in
            self?.dismiss(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
}
