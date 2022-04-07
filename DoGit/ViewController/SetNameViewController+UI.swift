//
//  SetNameViewController+UI.swift
//  DoGit
//
//  Created by neuli on 2022/04/07.
//

import UIKit

extension SetNameViewController: UITextFieldDelegate {
    
    func focusOnNameTextField() {
        nameTextField.becomeFirstResponder()
    }
    
    func configureUI() {
        
        // MARK: titleLabel
        titleLabel.text = "Github의 Name을 입력해주세요."
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // MARK: nameTextField
        nameTextField.borderStyle = .none
        nameTextField.textAlignment = .center
        nameTextField.tintColor = .mainColor
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(nameTextField)
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 55),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -55),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.layoutIfNeeded()
        nameTextField.underLine(borderColor: .mainColor)
        
        // MARK: doneButton
        doneButton.setTitle("확인", for: .normal)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.backgroundColor = .mainColor
        doneButton.layer.cornerRadius = 5
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(doneButton)
        
        NSLayoutConstraint.activate([
            doneButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            doneButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
        
        let doneBarButtonItem = UIBarButtonItem.init(customView: doneButton)
        
        // MARK: doneToolbar
        doneToolbar.sizeToFit()
        doneToolbar.barTintColor = .mainColor
        doneToolbar.isTranslucent = false
        doneToolbar.items = [doneBarButtonItem]
        
        nameTextField.inputAccessoryView = doneToolbar
        
    }
}