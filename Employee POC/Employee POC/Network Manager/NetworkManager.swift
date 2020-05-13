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
    
    func webserviceRequest<T: Decodable>(withType: String, andUrlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let webServiceURL = URL.init(string: andUrlString) else { return }
        var request = URLRequest(url: webServiceURL)
        request.httpMethod = withType
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
}
