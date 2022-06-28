//
//  GameListViewModelTest.swift
//  Casino Games AppTests
//
//  Created by Łukasz Czechowicz on 28/06/2022.
//

import XCTest
@testable import Casino_Games_App

class GameListViewModelTest: XCTestCase {

    var viewModel: GameListViewModel!
    let correctMockGameModelData = ["description": "test", "icon": "test.jpg", "name": "name", "theme": "RGB(ffffff)"]
    let failureMockGameModelData = ["another_description": "test", "icon": "test.jpg", "name": "name", "theme": "RGB(ffffff)"]
    let simpleIntData = 5
    let otherSimpleIntData = 500
    
    override func setUp() {
        viewModel = GameListViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
    }

    func testDecodingModelSuccess() throws {
        let model = try viewModel.decode(type: GameModel.self, from: correctMockGameModelData as AnyObject)
        XCTAssertEqual(model.name, correctMockGameModelData["name"])
    }
    
    func testDecodingModelFail() throws {
        XCTAssertThrowsError(try viewModel.decode(type: GameModel.self, from: failureMockGameModelData as AnyObject))
    }
    
    func testDecodingSimpleIntSuccess() throws {
        XCTAssertEqual(try viewModel.decode(type: Int.self, from: simpleIntData as AnyObject), simpleIntData)
    }
    
    func testDecodingSimpleIntNotEqual() throws {
        XCTAssertNotEqual(try viewModel.decode(type: Int.self, from: otherSimpleIntData as AnyObject), simpleIntData)
    }
}
