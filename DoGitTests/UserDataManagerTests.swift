//
//  UserDataManagerTests.swift
//  DoGitTests
//
//  Created by neuli on 2022/04/09.
//

import XCTest
@testable import DoGit

class UserDataManagerTests: XCTestCase {
    
    // sut: systemUnderTest
//    var sut: UserDataManager!
    
    override func setUpWithError() throws {
        // 테스트에서 가장 먼저 실행되는 메소드
        // 모델, 시스템 정의
//        sut = UserDataManager()
    }

    override func tearDownWithError() throws {
        // 테스트에서 가장 마지막에 실행되는 메소드
        // 해제
//        sut = nil
    }

    // func 테스트할 클래스 이름_테스트 상황_예상 결과()
    func testUserDataManager_WhenRightIdProvided_ShouldReturnId() async throws {
//        // arrange : 테스트에 필요한 클래스나 객체
//        let id: String = "NEULiee"
//
//        // action: 테스트
//        let providedId = try await sut.fetchUser(userId: id)
//
//        // assert: 결과 확인
//        XCTAssertEqual(id, providedId)
    }
    
    func testUserDataManager_WhenWrongIdProvided_ShouldReturnDoGitException() async throws {
//        let wrongId: String = "aaaaaaaasdasdasdasd"
//
//        try await sut.fetchUser(userId: wrongId)
//
//        XCTAssertThrowsError(DoGitError.userNameNotFound)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
