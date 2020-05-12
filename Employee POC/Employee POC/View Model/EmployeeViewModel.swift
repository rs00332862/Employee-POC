//
//  EmployeeViewModel.swift
//  Employee POC
//
//  Created by Rohit on 5/12/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation

class EmployeeViewModel {
    static var employeeList: [Employee] = [Employee]()
    
    func getEmployeeList(completion: @escaping (Result<Bool, Error>) -> Void) {
        NetworkManager.sharedInstance.getDataFromWebService(urlString: Constant.getEmployeeListURL) { (responseData: Result<EmployeeDataMadel,Error>) in
            DispatchQueue.main.async {
                switch(responseData) {
                case .success(let responseEmployeeList):
                    EmployeeViewModel.employeeList = responseEmployeeList.employeeData
                    completion(.success(true))
                case.failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    /// To return employee Object count for table view data source method
    /// Used this method if user want to know the count of employee list received from service
    ///
    /// - Returns: employee Model object count
    func getCountOfEmployeeyData() -> Int {
        return EmployeeViewModel.employeeList.count
    }
    
    /// To return categoryData Object for provided cell number
    ///
    /// - Parameter forCellNumber: index number of cell so data can be return for approriate cell
    /// - Returns: CategoryData Model  Object contains title, description and imageURL data
    func getEmployeeDataObject(forCellNumber: Int) -> Employee {
        return EmployeeViewModel.employeeList[forCellNumber]
    }
}
