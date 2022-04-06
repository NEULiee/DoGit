//
//  Todo.swift
//  DoGit
//
//  Created by neuli on 2022/04/06.
//

import Foundation
import RealmSwift

class Todo: Object {
    
    @Persisted var isDone: Bool = false
    @Persisted var content: String = ""
}
