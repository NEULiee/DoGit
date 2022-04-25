//
//  WriteTodoViewController.swift
//  DoGit
//
//  Created by neuli on 2022/04/19.
//

import UIKit
import RealmSwift

class WriteTodoViewController: UIViewController {
    
    let realm = try! Realm()
    
    let titleLabel = UILabel()
    let contentTextField = UITextField()
    let doneButton = UIButton()
    let repository: Repository!
    let todo: Todo!
    
    init(repository: Repository) {
        self.repository = repository
        self.todo = nil
        self.titleLabel.text = "할일 추가하기"
        super.init(nibName: nil, bundle: nil)
    }
    
    init(todo: Todo) {
        self.repository = nil
        self.todo = todo
        self.titleLabel.text = "할일 수정하기"
        self.contentTextField.text = todo.content
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
            if self.contentTextField.text != "" {
                self.contentTextField.selectAll(self)
            }
        }
    }
}
