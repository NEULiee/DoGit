//
//  SetNameViewController.swift
//  DoGit
//
//  Created by neuli on 2022/04/07.
//

import UIKit

class SetNameViewController: UIViewController {
    
    // MARK: - Properties
    // MARK: UI Properties
    let titleLabel = UILabel()
    let nameTextField = UITextField()
    let doneToolbar = UIToolbar()
    let doneButton = UIButton()
    
    let hapticNotification = UINotificationFeedbackGenerator()
    
    // MARK: URLSession
    let githubDataManager = GithubDataManager()
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        focusOnNameTextField()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Methods
    func showAlertRewrite(message errorDescription: String) {
        let alert = UIAlertController(title: "", message: errorDescription, preferredStyle: .alert)
        alert.view.accessibilityIdentifier = "nameAlert"
        alert.view.tintColor = .mainColor
        alert.addAction(UIAlertAction(title: "다시입력", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.view.accessibilityIdentifier = "nameAlert"
        alert.view.tintColor = .mainColor
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
