//
//  UIColor_Extension.swift
//  Casino Games AppTests
//
//  Created by Łukasz Czechowicz on 28/06/2022.
//

import XCTest
@testable import Casino_Games_App

class UIColor_ExtensionTest: XCTestCase {

    let correctStringColor = "RGB(ffffff)"
    let incorrectStringColor = "#ffffff"
   
    func testStringToUIColorParsingSuccess() throws {
        XCTAssertTrue(UIColor.from(string: correctStringColor)!.isEqualTo(.white))
    }
    
    func testStringToUIColorParsingFailure() throws {
        XCTAssertNil(UIColor.from(string: incorrectStringColor))
    }

}
