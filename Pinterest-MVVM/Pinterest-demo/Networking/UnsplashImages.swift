//
//  UnsplashImages.swift
//  Pinterest-demo
//
//  Created by Vishal  on 10/08/19.
//  Copyright © 2019 Vishal. All rights reserved.
//

import Foundation

typealias Photos = [Photo]

// MARK: - Photo
struct Photo : Codable {
    let urls: Urls?
}

// MARK: - Urls
struct Urls : Codable {
    let raw, full, regular, small: String?
    let thumb: String?
}
