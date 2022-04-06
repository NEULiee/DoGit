//
//  User.swift
//  DoGit
//
//  Created by neuli on 2022/04/06.
//

import Foundation
import RealmSwift

class User: Object {
    
    @Persisted var userName: String = ""
    
    convenience init(userName: String) {
        self.init()
        self.userName = userName
    }
}
