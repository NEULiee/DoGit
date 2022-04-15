//
//  TodoRepositoryStore.swift
//  DoGit
//
//  Created by neuli on 2022/04/15.
//

import Foundation
import RealmSwift

class TodoRepositoryStore {
    
    static let shared = TodoRepositoryStore()
    let realm = try! Realm()
    
    func readAll() -> [Repository] {
        let repositories = Array(realm.objects(Repository.self))
        return repositories
    }
}
