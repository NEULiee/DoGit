//
//  Todo.swift
//  DoGit
//
//  Created by neuli on 2022/04/06.
//

import Foundation
import RealmSwift

class Repository: Object {
    
    @Persisted var id: String
    @Persisted var name: String
    
    @Persisted var todos = List<Todo>()
    
    convenience init(id: String, name: String) {
        self.init()
        self.id = id
        self.name = name
    }
}
