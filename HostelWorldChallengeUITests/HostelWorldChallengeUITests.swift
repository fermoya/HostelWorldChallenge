//
//  HostelWorldChallengeUITests.swift
//  HostelWorldChallengeUITests
//
//  Created by Fernando Moya de Rivas on 28/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import XCTest
import Domain

class HostelWorldChallengeUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append(LaunchArguments.UITesting)
        app.launch()
    }

    func testExample() {
        let expectedFirstPropertyName = "STF Vandrarhem Stigbergsliden"
        let table = app.tables.matching(identifier: "propertiesTableView")
        
        let firstCell = table.children(matching: .cell).element(boundBy: 0)
        let firstCellNameLabel = firstCell.staticTexts[expectedFirstPropertyName]
        
        XCTAssertTrue(firstCellNameLabel.exists)
        
        firstCell.tap()
        
        let detailNameLabel = app.staticTexts[expectedFirstPropertyName]
        XCTAssertTrue(detailNameLabel.exists)
    }

}
