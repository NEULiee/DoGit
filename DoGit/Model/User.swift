//
//  User.swift
//  DoGit
//
//  Created by neuli on 2022/04/06.
//

import Foundation
import RealmSwift

class User: Object {
    
    @Persisted var name: String
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
