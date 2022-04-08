//
//  SetNameViewController+Actions.swift
//  DoGit
//
//  Created by neuli on 2022/04/08.
//

import UIKit

extension SetNameViewController {
    
    @objc func didChangeNameTextField(_ sender: UITextField) {
        self.doneButton.isEnabled = sender.text == "" ? false : true
    }
    
    @objc func didPressDoneButton(_ sender: UIButton) {

    }
}
