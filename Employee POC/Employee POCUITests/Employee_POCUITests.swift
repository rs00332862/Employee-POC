//
//  Employee_POCUITests.swift
//  Employee POCUITests
//
//  Created by Rohit on 5/11/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import XCTest

class Employee_POCUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // to validate add employee name field
    func testAddEmployeeNameFieldsValidation() {
        
        app.navigationBars["Employee List"].buttons["Add"].tap()
        let submitButton = app.buttons["Submit"]
        let employeeNameErrorLabel = app.staticTexts["employeeNameErrorLabel"]
        submitButton.tap()
        XCTAssertEqual(employeeNameErrorLabel.label, "Please enter employee name")
        app.textFields["Employee Name"].tap()
        app.textFields["Employee Name"].typeText("Rohit ^%&%")
        submitButton.tap()
        XCTAssertEqual(employeeNameErrorLabel.label, "Please enter valid user name")
        app.textFields["Employee Name"].tap()
        app.textFields["Employee Name"].clearAndEnterText(text: "Rohit Shivankar")
        submitButton.tap()
        XCTAssertFalse(employeeNameErrorLabel.exists)
    }
    
    // to validate add employee age field
    func testAddEmployeeEmployeeAgeValidation() {
        
        app.navigationBars["Employee List"].buttons["Add"].tap()
        app/*@START_MENU_TOKEN@*/.textFields["employeeNameTextField"]/*[[".textFields[\"Employee Name\"]",".textFields[\"employeeNameTextField\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.textFields["employeeNameTextField"]/*[[".textFields[\"Employee Name\"]",".textFields[\"employeeNameTextField\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.typeText("Rohit")
        let employeeAgeTextField = app/*@START_MENU_TOKEN@*/.textFields["employeeAgeTextField"]/*[[".textFields[\"Employee Age\"]",".textFields[\"employeeAgeTextField\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        employeeAgeTextField.tap()
        employeeAgeTextField.typeText("23@")
        let submitButton = app.buttons["Submit"]
        submitButton.tap()
        XCTAssertEqual(app.staticTexts["employeeAgeErrorLabel"].label, "Please enter valid age")
        employeeAgeTextField.clearAndEnterText(text: "23")
        submitButton.tap()
        XCTAssertFalse(app.staticTexts["employeeAgeErrorLabel"].exists)
    }
    
    // to validate add employee salary field
    func testtestAddEmployeeEmployeeSalaryValidation(){
        
        app.navigationBars["Employee List"].buttons["Add"].tap()
        app/*@START_MENU_TOKEN@*/.textFields["employeeNameTextField"]/*[[".textFields[\"Employee Name\"]",".textFields[\"employeeNameTextField\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.textFields["employeeNameTextField"]/*[[".textFields[\"Employee Name\"]",".textFields[\"employeeNameTextField\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.typeText("Rohit")
        let employeeAgeTextField = app/*@START_MENU_TOKEN@*/.textFields["employeeAgeTextField"]/*[[".textFields[\"Employee Age\"]",".textFields[\"employeeAgeTextField\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        employeeAgeTextField.tap()
        employeeAgeTextField.typeText("23")
        let employeeSalaryTextField = app.textFields["employeeSalaryTextField"]
        employeeSalaryTextField.tap()
        employeeSalaryTextField.typeText("AS23")
        let submitButton = app.buttons["Submit"]
        submitButton.tap()
        XCTAssertTrue(app.staticTexts["employeeSalaryErrorLabel"].exists)
        employeeSalaryTextField.tap()
        employeeSalaryTextField.clearAndEnterText(text: "1234")
        submitButton.tap()
        XCTAssertFalse(app.staticTexts["employeeSalaryErrorLabel"].exists)
    }
    
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}

extension XCUIElement {
    
    ///Removes any current text in the field before typing in the new value
    ///- Parameter text: the text to enter into the field
    ///
    func clearAndEnterText(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        self.tap()
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        self.typeText(deleteString)
        self.typeText(text)
    }
}
