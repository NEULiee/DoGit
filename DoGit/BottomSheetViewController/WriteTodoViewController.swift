//
//  WriteTodoViewController.swift
//  DoGit
//
//  Created by neuli on 2022/04/19.
//

import UIKit

class WriteTodoViewController: UIViewController {
    
    let titleLabel = UILabel()
    let contentTextField = UITextField()
    let doneButton = UIButton()
    let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        focusOnContentTextField()
    }
    
    func focusOnContentTextField() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25) {
            self.contentTextField.becomeFirstResponder()
        }
    }
}
