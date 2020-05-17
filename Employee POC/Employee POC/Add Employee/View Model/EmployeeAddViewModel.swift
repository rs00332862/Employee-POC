//
//  EmployeeAddViewModel.swift
//  Employee POC
//
//  Created by Rohit on 5/17/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation

class EmployeeAddViewModel {
    var employeeName: String = ""
    var employeeAge: String = ""
    var employeeSalary: String = ""
    
    func createEmployee(completion: @escaping (Result<Bool, Error>) -> Void) {
        let employee = NewEmployee(name: self.employeeName, salary: self.employeeSalary, age: self.employeeAge, id: 0)
        
        NetworkManager.sharedInstance.createNewEmployee(employeeData: employee) { (result) in
            DispatchQueue.main.async {
                switch(result) {
                case .success(let response):
                    print(response)
                    completion(.success(true))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
