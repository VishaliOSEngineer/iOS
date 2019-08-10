//
//  ViewModel.swift
//  Pinterest-demo
//
//  Created by Vishal  on 10/08/19.
//  Copyright © 2019 Vishal. All rights reserved.
//

import Foundation
import UIKit

struct CellViewModel {
    let image : UIImage
}

class ViewModel {
    // MARK:  Properties
    private let client : APIClient
    private var photos : Photos = [] {
        didSet {
            self.fetchPhoto()
        }
    }
    var cellViewModels : [CellViewModel] = []
    // MARK:  UI
    var isLoading = false {
        didSet {
            showLoading?()
        }
    }
    var showLoading : (() -> Void)?
    var reloadData : (() -> Void)?
    var showError : ((Error) -> Void)?
    
    init(client: APIClient) {
        self.client = client
    }
    
    func fetchPhotos() {
        if let client = client as? UnsplashClient {
            self.isLoading = true
            let endPoint = UnsplashEndpoint.photos()
            client.fetch(with: endPoint) { (either) in
                switch either {
                case .error(let error) : self.showError?(error)
                    
                case .success(let photos) : self.photos = photos
                }
            }
        }
    }
    
    private func fetchPhoto() {
        self.photos.forEach { (photo) in
            if let url = URL(string: photo.urls?.small ?? ""){
                    guard let imageData = try? Data(contentsOf: url) else {
                        self.showError?(APIError.imageDownload)
                        return }
                    guard let image = UIImage(data: imageData) else {
                        self.showError?(APIError.imageConvert)
                        return }
                    self.cellViewModels.append(CellViewModel(image: image))
                    self.isLoading = false
                    self.reloadData?()
                }
        }
    }
}










