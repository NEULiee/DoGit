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
    
    let userDataManager = UserDataManager()
    
    let hapticNotification = UINotificationFeedbackGenerator()
    
    override func viewWillAppear(_ animated: Bool) {
        focusOnNameTextField()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}
