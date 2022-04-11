//
//  Font.swift
//  DoGit
//
//  Created by neuli on 2022/04/11.
//

import UIKit

    // UIFont(name: Font.NEXONLv1GothicLowOTFRegular.rawValue, size: 18)

extension UIFont {
    
    class Font {
        static let regular18: UIFont = UIFont(name: "NEXONLv1GothicLowOTFRegular", size: 18) ?? UIFont.systemFont(ofSize: 18)
        static let regular24: UIFont = UIFont(name: "NEXONLv1GothicLowOTFRegular", size: 24) ?? UIFont.systemFont(ofSize: 24)
        static let regular32: UIFont = UIFont(name: "NEXONLv1GothicLowOTFRegular", size: 32) ?? UIFont.systemFont(ofSize: 32)
        
        static let light18: UIFont = UIFont(name: "NEXONLv1GothicLowOTFLight", size: 18) ?? UIFont.systemFont(ofSize: 18)
        static let light24: UIFont = UIFont(name: "NEXONLv1GothicLowOTFLight", size: 24) ?? UIFont.systemFont(ofSize: 24)
        static let light32: UIFont = UIFont(name: "NEXONLv1GothicLowOTFLight", size: 32) ?? UIFont.systemFont(ofSize: 32)
        
        static let bold18: UIFont = UIFont(name: "NEXONLv1GothicLowOTFBold", size: 18) ?? UIFont.systemFont(ofSize: 18)
        static let bold24: UIFont = UIFont(name: "NEXONLv1GothicLowOTFBold", size: 24) ?? UIFont.systemFont(ofSize: 24)
        static let bold32: UIFont = UIFont(name: "NEXONLv1GothicLowOTFBold", size: 32) ?? UIFont.systemFont(ofSize: 32)
    }
}
