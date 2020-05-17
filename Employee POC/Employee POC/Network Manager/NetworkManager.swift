//
//  NetworkManager.swift
//  TelstraPOC
//
//  Created by Rohit on 5/6/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    
    /// method to initiate web service call
    ///
    /// - Parameter withType: request type to make service call,  urlString: URL to initiate web service call, requestData: data which we need to pass in request body
    func webserviceRequest<T: Decodable>(withType: String, urlString: String, requestData: Data, completion: @escaping (Result<T, Error>) -> Void) {
        guard let webServiceURL = URL.init(string: urlString) else { return }
        var request = URLRequest(url: webServiceURL)
        request.httpMethod = withType
        if(withType == "POST"){
            request.httpBody = requestData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let errorObject = error {
                completion(.failure(errorObject))
            } else {
                guard let data = data else { return }
                let jsonString = String(decoding: data, as: UTF8.self)
                do {
                    let responseData = try JSONDecoder().decode(T.self, from: jsonString.data(using: .utf8)!)
                    completion(.success(responseData))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    /// method to initiate get employee data webservice
    ///
    func getEmployeeList(completion: @escaping (Result<EmployeeDataMadel,Error>) -> Void) {
        let urlString = Constant.getEmployeeListURL
        webserviceRequest(withType: "Get", urlString: urlString, requestData: Data()) { (responseData:  Result<EmployeeDataMadel,Error>) in
            switch(responseData) {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// method to initiate delete employee data service call
    ///
    /// - Parameter employeeID: employee ID whose data we want to delete from server
    func deleteEmployeeFromList(employeeID: String, completion: @escaping (Result<deleteServiceModel,Error>) -> Void) {
        let urlString = Constant.deleteEmployeeFromListURL+employeeID
        webserviceRequest(withType: "Delete", urlString: urlString, requestData: Data()) { (responseData:  Result<deleteServiceModel,Error>) in
            switch(responseData) {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// method to initiate save employee data webservice
    ///
    /// - Parameter employeeData: employeeData object which we want to pass in request body
    func createNewEmployee(employeeData: NewEmployee, completion: @escaping (Result<NewEmployeeResponseModel, Error>) -> Void) {
        let urlString = Constant.saveEmployeeDataURL
        guard let requestBody = try? JSONEncoder().encode(employeeData) else { return }
        webserviceRequest(withType: "POST", urlString: urlString, requestData: requestBody) { (responseData:  Result<NewEmployeeResponseModel,Error>) in
            switch(responseData) {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
