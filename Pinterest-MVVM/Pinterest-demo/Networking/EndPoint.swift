//
//  EndPoint.swift
//  Pinterest-demo
//
//  Created by Vishal  on 10/08/19.
//  Copyright © 2019 Vishal. All rights reserved.
//

import Foundation

protocol Endpoint {
    var baseUrl : String { get }
    var path : String { get }
}

extension Endpoint {
    
    var urlComonent : URLComponents {
        var urlComponent = URLComponents(string: baseUrl)
        urlComponent?.path = path
        return urlComponent!
    }
    var request : URLRequest {
        return URLRequest(url: urlComonent.url!)
    }
}

enum Order :String {
    case latest, popular, oldest
}

enum UnsplashEndpoint: Endpoint {
    case photos()
    
    var baseUrl: String {
        return "http://pastebin.com"
    }
    var path: String {
        switch self {
        case .photos:
            return "/raw/wgkJgazE"
        }
    }
    var urlParameters:URLRequest {
        switch self {
        case .photos():
            return request
        }
    }
}
