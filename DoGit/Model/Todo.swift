//
//  Todo.swift
//  DoGit
//
//  Created by neuli on 2022/04/06.
//

import Foundation
import RealmSwift

class Todo: Object, Identifiable {
    
    @Persisted var id: String = UUID().uuidString
    @Persisted var isDone: Bool = false
    @Persisted var content: String = ""
}

extension Array where Element == Todo {
    func indexOfTodo(with id: Todo.ID) -> Self.Index {
        guard let index = firstIndex(where: { $0.id == id }) else { fatalError() }
        return index
    }
}
