//
//  APIManager.swift
//  News App
//
//  Created by Krishna on 25/09/19.
//  Copyright © 2019 Krishna. All rights reserved.
//


import Foundation
import UIKit

public typealias HTTPHeaders = [String: String]

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

typealias Parameters = [String: Any]

enum commonError : Error{
    case noDataAvailabel
    case canNotProcessData
}

class APIManager {
    
    // MARK: - Singleton -
    class var sharedInstance:APIManager {
        struct Static{
            static let _instance = APIManager()
        }
        return Static._instance
    }
    
    // Mark :-  For GetRequest
    func getRequestAPI(url:String,completion: @escaping(_ news : NewsList?, _ error: Error?) -> Void){
        guard let serviceUrl = URL(string: url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = RequestMethod.get.rawValue
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let responseData = data else {
                print("Data is nil")
                completion(nil, error)
                return
            }
            self.createNewsObjectWith(json: responseData, completion: { (news, error) in
                if let error = error {
                    print("Failed to convert data")
                    return completion(nil, error)
                }
                return completion(news, nil)
            })
            }.resume()
    }
    
    func createNewsObjectWith(json: Data, completion: @escaping (_ data: NewsList?, _ error: Error?) -> Void) {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let news = try decoder.decode(NewsList.self, from: json)
            return completion(news, nil)
        } catch let error {
            print("Error creating current weather from JSON because: \(error.localizedDescription)")
            return completion(nil, error)
        }
    }
    
    func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        print("Download Started")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                completion(nil,nil,error)
            }
            completion(data,response,nil)
        }.resume()
    }
}

