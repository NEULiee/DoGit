//
//  UITextField+UnderLine.swift
//  DoGit
//
//  Created by neuli on 2022/04/07.
//

import UIKit

extension UITextField {
    
    func underLine(borderColor: UIColor) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.size.height + 2, width: self.frame.width, height: 1)
        border.borderWidth = 1
        border.borderColor = borderColor.cgColor
        self.layer.addSublayer(border)
    }
}
