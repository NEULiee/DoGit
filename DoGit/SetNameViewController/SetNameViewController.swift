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
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Github의 아이디를 입력해주세요."
        label.font = .regular18
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.accessibilityIdentifier = "nameTextField"
        textField.font = .regular18
        textField.borderStyle = .none
        textField.textAlignment = .center
        textField.tintColor = .mainColor
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .alphabet
        return textField
    }()
    
    let doneToolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.barTintColor = .mainColor
        toolbar.isTranslucent = false
        return toolbar
    }()
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.accessibilityIdentifier = "doneButton"
        button.titleLabel?.font = .regular18
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .mainColor
        return button
    }()
    
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
