//
//  BottomSheetViewController+Realm.swift
//  DoGit
//
//  Created by neuli on 2022/04/23.
//

import UIKit

extension BottomSheetViewController {
    
    func todoNotification() {
        realmTodos = realm.objects(Todo.self)
        notificationToken = realmTodos.observe { [weak self] changes in
            switch changes {
            case .initial:
                break
            case .update(_, _, let insertions, _):
                if 0 < insertions.count {
                    self?.hideBottomSheetAndGoBack()
                }
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
}
