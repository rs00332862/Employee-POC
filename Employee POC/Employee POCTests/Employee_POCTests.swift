//
//  Employee_POCTests.swift
//  Employee POCTests
//
//  Created by Rohit on 5/11/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import XCTest
@testable import Employee_POC

class Employee_POCTests: XCTestCase {
    
    let employeeViewModel = EmployeeViewModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testGetEmployeesDataFromWebService()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetEmployeesDataFromWebService() {
        let expectation = self.expectation(description: "Web Service response successful.")
        employeeViewModel.getEmployeeList { (result) in
            switch(result) {
            case .success(let result):
                XCTAssertNotNil(result)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 7, handler: nil)
    }
    
    func testEmployeeSearchResultCount() {
        employeeViewModel.filterEmployeeDataWith(string: "Ce") {
            XCTAssertEqual(EmployeeViewModel.filteredEmployeesList.count, 2)
        }
    }
    
    func testEmployeeSearchResultData() {
        employeeViewModel.filterEmployeeDataWith(string: "Ce") {
            let firstSearchedResult = EmployeeViewModel.filteredEmployeesList[0]
            XCTAssertEqual(firstSearchedResult.employeeID, "4")
            XCTAssertEqual(firstSearchedResult.employeeName, "Cedric Kelly")
            XCTAssertEqual(firstSearchedResult.employeeAge, "22")
            XCTAssertEqual(firstSearchedResult.employeeSalary, "433060")
        }
        
    }
    
    func testEmployeeSearchZeroResult() {
        employeeViewModel.filterEmployeeDataWith(string: "Rohit") {
            XCTAssertEqual(EmployeeViewModel.filteredEmployeesList.count, 0)
        }
    }
    
    func testEmployeeDeleteSucessResponse() {
        let expectation = self.expectation(description: "Delete Web Service response successful.")
        employeeViewModel.deleteEmployeeFromList(forCellNumber: 0, IsFilteringOn: false, completion: {result in
            switch(result) {
            case .success(let result):
                XCTAssertNotNil(result)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 7, handler: nil)
    }
    
}
