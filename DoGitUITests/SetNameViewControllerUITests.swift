//
//  SetNameViewControllerTests.swift
//  DoGitUITests
//
//  Created by neuli on 2022/04/13.
//
// 이름을 입력시 화면이 dismiss 되는지
// 이름 입력시 DB에 저장이 되는지

import XCTest
import RealmSwift
@testable import DoGit

class SetNameViewControllerUITests: XCTestCase {
    
    private var app: XCUIApplication!
    private var nameTextField: XCUIElement!
    private var doneButton: XCUIElement!

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func test_providedWrongUserName_showAlert() throws {
        let app = XCUIApplication()
        app.launch()

        nameTextField = app.textFields["nameTextField"]
        doneButton = app.buttons["doneButton"]
        
        nameTextField.typeText("NEULieeNEULieeNEULieeNEULiee")
        doneButton.tap()
        
        XCTAssertTrue(app.alerts["nameAlert"].waitForExistence(timeout: 1), "이름 잘못입력하면 떠야되는데 안떴음")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
