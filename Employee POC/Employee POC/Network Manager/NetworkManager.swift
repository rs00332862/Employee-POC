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
    
    func getDataFromWebService<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let webServiceURL = URL.init(string: urlString) else { return }
        URLSession.shared.dataTask(with: webServiceURL) { (data, response, error) in
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
