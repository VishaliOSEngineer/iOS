//
//  APIClient.swift
//  Pinterest-demo
//
//  Created by Vishal  on 10/08/19.
//  Copyright © 2019 Vishal. All rights reserved.
//

import Foundation

enum Either<T> {
    case success(T)
    case error(Error)
}

enum APIError :Error {
    case unknown, badResponse,JsonDecoder,imageDownload,imageConvert
}

protocol APIClient {
    var session : URLSession { get }
    func get<T:Codable>(with request:URLRequest,handler :@escaping (Either<[T]>) -> ())
}

extension APIClient {
    
    var session : URLSession {
        return URLSession.shared
    }
    
    func get<T:Codable>(with request:URLRequest,handler :@escaping (Either<[T]>) -> ()) {
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else { handler(.error(error!)) ; return}
            
            guard let response = response as? HTTPURLResponse , 200..<300 ~= response.statusCode else {handler(.error(APIError.badResponse)); return}
            
            guard let value = try? JSONDecoder().decode([T].self, from: data!) else { handler(.error(APIError.JsonDecoder)); return}
            
            DispatchQueue.main.async {
                handler(.success(value))
            }
        } ; task.resume()
    }
}
