//
//  DoGitError.swift
//  DoGit
//
//  Created by neuli on 2022/04/08.
//

import Foundation

enum DoGitError: LocalizedError {
    
    case failedConnectServer
    case userNameNotFound
    case repositoryNotFound
    
    var errorDescription: String? {
        
        switch self {
        case .failedConnectServer:
            return NSLocalizedString("서버연결에 실패했어요.", comment: "fail to connect server")
        case .userNameNotFound:
            return NSLocalizedString("존재하지 않는 이름이에요.", comment: "user name not found")
        case .repositoryNotFound:
            return NSLocalizedString("저장소를 찾을 수 없어요.", comment: "github repository not found")
        }
    }
}
