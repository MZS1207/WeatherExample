//
//  WeatherAppUITests.swift
//  WeatherAppUITests
//
//  Created by Milos Stevanovic on 8/29/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//

import XCTest

class WeatherAppUITests: XCTestCase {
    
    var app : XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    func testWorkflow() {
        app.launch()
        
        let shareButton = app.buttons[UIElementTestIdentifiers.testShareButton.description]
        XCTAssertNotNil(shareButton)
        shareButton.tap()
        
        let tabBarItemForecast =
        app.tabBars.buttons["Forecast"]
        XCTAssertNotNil(tabBarItemForecast)
        tabBarItemForecast.tap()

        let forecastTableView = app.tables["testTableViewForecast"]
        XCTAssertNotNil(forecastTableView)
        
        _ = forecastTableView.waitForExistence(timeout: 2.0)
        
        forecastTableView.swipeDown()
        forecastTableView.swipeUp()
        
        testValuesOnForecast(tableView: forecastTableView)
        
        let tabBaritemToday = app.tabBars.buttons["Today"]
        XCTAssertNotNil(tabBaritemToday)
        tabBaritemToday.tap()
    }
    func testValuesOnForecast(tableView : XCUIElement){
         let tableCells = tableView.cells
        
        if tableCells.count > 1 {
            let numberOfCells  = tableCells.count - 1
            let promise = expectation(description: "Wait to check all cells content")
        
            for row in stride(from: 0, to: numberOfCells, by: 1){
                
                let forecastCell = tableCells.element(boundBy: row)
                XCTAssertNotNil(forecastCell)
                let imageLogo  =
                    forecastCell.children(matching: .image).element
                XCTAssertNotNil(imageLogo)
                
                let labelsInCell = forecastCell.children(matching: .staticText).allElementsBoundByIndex
                for element in labelsInCell {
                   XCTAssertTrue(element.label != "", "label should have value in cell")
                }
                if row == numberOfCells - 1{
                    promise.fulfill()
                }
            }
            wait(for: [promise], timeout: 30)
        }
    }
    func testCheckAllLabelsValue(){
        
        let  allLabelsInApp = app.staticTexts.allElementsBoundByIndex
        for element in allLabelsInApp {
             XCTAssertTrue(element.label != "", "label should have value ")
        }
    }
}
