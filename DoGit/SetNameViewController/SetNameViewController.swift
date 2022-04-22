//
//  SetNameViewController.swift
//  DoGit
//
//  Created by neuli on 2022/04/07.
//

import UIKit

class SetNameViewController: UIViewController {
    
    let titleLabel = UILabel()
    let nameTextField = UITextField()
    let doneToolbar = UIToolbar()
    let doneButton = UIButton.init(type: .custom)
    
    let githubDataManager = GithubDataManager()
    
    let hapticNotification = UINotificationFeedbackGenerator()
    
    override func viewWillAppear(_ animated: Bool) {
        focusOnNameTextField()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
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
