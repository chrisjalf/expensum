//
//  APICaller.swift
//  Expensum
//
//  Created by Chris James on 04/04/2022.
//

import Foundation

struct Constants {
    static let host = "localhost:3000"
    static let baseUrl = "http://\(host)"
}

enum APIError: Error {
    case error(message: String)
    
    var localizedDescription: String {
        switch self {
        case .error(message: let message):
            return message
        }
    }
}

class APICaller {
    static let shared = APICaller()
    
    func getJwtToken() -> String {
        guard let data = KeychainHelper.standard.read(service: "access_token", account: "expensum") else { return "Token empty" }

        let accessToken = String(data: data, encoding: .utf8)!
        return accessToken
    }
    
    func login(email: String, password: String, completion: @escaping (Result<String, APIError>) -> Void) {
        guard let url = URL(string: "\(Constants.baseUrl)/login") else { return }
        
        let request: URLRequest = {
            var requestBodyComponents = URLComponents()
            requestBodyComponents.queryItems = [
                URLQueryItem(name: "email", value: email),
                URLQueryItem(name: "password", value: password)
            ]
            
            var r = URLRequest(url: url)
            r.httpMethod = "POST"
            r.httpBody = requestBodyComponents.query?.data(using: .utf8)
            
            return r
        }()
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(LoginResponse.self, from: data)
                
                if results.success == true {
                    let accessToken = results.token!
                    let data = Data(accessToken.utf8)
                    KeychainHelper.standard.save(data: data, service: "access_token", account: "expensum")
                    
                    completion(.success("Ok"))
                } else {
                    throw APIError.error(message: results.message)
                }
            } catch {
                let err = error as! APIError
                completion(.failure(err))
            }
        }
        
        task.resume()
    }
    
    func getCategories(completion: @escaping (Result<[Category], APIError>) -> Void) {
        guard let url = URL(string: "\(Constants.baseUrl)/categories") else { return }
        
        let request: URLRequest = {
            var r = URLRequest(url: url)
            r.httpMethod = "POST"
            r.addValue(getJwtToken(), forHTTPHeaderField: "Authorization")
            return r
        }()
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(CategoriesResponse.self, from: data)
                
                if results.success == true {
                    completion(.success(results.categories!))
                } else {
                    throw APIError.error(message: results.message)
                }
            } catch {
                let err = error as! APIError
                completion(.failure(err))
            }
        }
        
        task.resume()
    }
    
    func getTransactions(params: [URLQueryItem], completion: @escaping (Result<TransactionsResponse, APIError>) -> Void) {
        guard let url = URL(string: "\(Constants.baseUrl)/transactions") else { return }
        
        let request: URLRequest = {
            var r = URLRequest(url: url)
            r.httpMethod = "POST"
            r.addValue(getJwtToken(), forHTTPHeaderField: "Authorization")
            
            if params.count > 0 {
                var requestBodyComponents = URLComponents()
                requestBodyComponents.queryItems = params
                
                r.httpBody = requestBodyComponents.query?.data(using: .utf8)
            }
            
            return r
        }()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TransactionsResponse.self, from: data)
                
                if results.success == true {
                    completion(.success(results))
                } else {
                    throw APIError.error(message: results.message)
                }
            } catch {
                let err = error as! APIError
                completion(.failure(err))
            }
        }
        
        task.resume()
    }
    
    func addTransaction(params: [URLQueryItem], completion: @escaping (Result<String, APIError>) -> Void) {
        guard let url = URL(string: "\(Constants.baseUrl)/transaction/add") else { return }
        
        let request: URLRequest = {
            var r = URLRequest(url: url)
            r.httpMethod = "POST"
            r.addValue(getJwtToken(), forHTTPHeaderField: "Authorization")
            
            if params.count > 0 {
                var requestBodyComponents = URLComponents()
                requestBodyComponents.queryItems = params
                
                r.httpBody = requestBodyComponents.query?.data(using: .utf8)
            }
            
            return r
        }()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TransactionResponse.self, from: data)
                
                if results.success == true {
                    completion(.success(""))
                } else {
                    throw APIError.error(message: results.message)
                }
            } catch {
                print(error)
                let err = error as! APIError
                completion(.failure(err))
            }
        }
        
        task.resume()
    }
}
