//
//  EmployeeAddTests.swift
//  Employee POCTests
//
//  Created by Rohit on 5/17/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import XCTest
@testable import Employee_POC

class EmployeeAddTests: XCTestCase {
    
    let employeeAddViewModel = EmployeeAddViewModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAddEmployeeSucess() {
        employeeAddViewModel.employeeName = "Test Employee"
        employeeAddViewModel.employeeAge = "123"
        employeeAddViewModel.employeeSalary = "123456"
        employeeAddViewModel.createEmployee {result in
            switch(result) {
            case .success(let successResponse):
                XCTAssertNotNil(successResponse)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    
}
