//
//  DoGitError.swift
//  DoGit
//
//  Created by neuli on 2022/04/08.
//

import Foundation

enum DoGitError: Error {
    
    case userNameNotFound
    case nameValidation
    
    var errorDescription: String? {
        switch self {
        case .userNameNotFound:
            return String("존재하지 않는 이름이에요.")
        case .nameValidation:
            return String("39자까지 입력할 수 있어요.")
        }
    }
}
