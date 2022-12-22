//
//  SetNameViewController+UI.swift
//  DoGit
//
//  Created by neuli on 2022/04/07.
//

import UIKit

extension SetNameViewController {
    func focusOnNameTextField() {
        nameTextField.becomeFirstResponder()
    }
    
    func configureUI() {
        view.backgroundColor = .backgroundColor
        
        // MARK: titleLabel
        view.addSubview(titleLabel)
        titleLabel.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            paddingTop: 100
        )
        titleLabel.centerX(inview: view)
        
        // MARK: nameTextField
        view.addSubview(nameTextField)
        nameTextField.anchor(
            top: titleLabel.bottomAnchor,
            leading: view.safeAreaLayoutGuide.leadingAnchor,
            trailing: view.safeAreaLayoutGuide.trailingAnchor,
            paddingTop: 40,
            paddingLeading: 55,
            paddingTrailing: -55
        )
        nameTextField.centerX(inview: view)
        view.layoutIfNeeded()
        nameTextField.setNameUnderLine(borderColor: .mainColor)
        
        // MARK: doneButton
        doneButton.addTarget(
            self,
            action: #selector(didPressDoneButton(_:)),
            for: .touchUpInside
        )
        let doneBarButtonItem = UIBarButtonItem.init(customView: doneButton)
        
        // MARK: doneToolbar
        doneToolbar.items = [doneBarButtonItem]
        doneToolbar.updateConstraintsIfNeeded()
        nameTextField.inputAccessoryView = doneToolbar
    }
}
