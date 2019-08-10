//
//  UnsplashClient.swift
//  Pinterest-demo
//
//  Created by Vishal  on 10/08/19.
//  Copyright © 2019 Vishal. All rights reserved.
//

import Foundation

class UnsplashClient : APIClient{
    func fetch(with endpoint:UnsplashEndpoint,completion : @escaping (Either<Photos>)->()) {
        let request = endpoint.request
        get(with: request, handler: completion)
    }
}
