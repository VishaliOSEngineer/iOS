//
//  ViewController.swift
//  Pinterest-demo
//
//  Created by Vishal  on 10/08/19.
//  Copyright © 2019 Vishal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK:  Outlets
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    let viewModel = ViewModel(client: UnsplashClient())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        // init View model
        viewModel.showLoading = {
            if self.viewModel.isLoading {
                self.activityIndicator.startAnimating()
                self.collectionView.alpha = 0.0
            } else {
                self.activityIndicator.stopAnimating()
                self.collectionView.alpha = 1.0
            }
        }
        viewModel.showError = { error in
            print(error)
        }
        viewModel.reloadData = {
            self.collectionView.reloadData()
        }
        viewModel.fetchPhotos()
    }
}

// MARK:  Flow-Layout Delegate

extension ViewController : PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        // for big height images
        let image = viewModel.cellViewModels[indexPath.row].image
        let modifiedImageHeight = image.size.height
        if modifiedImageHeight > self.view.frame.height / 2 {
            return self.view.frame.height / 2
        }
        return modifiedImageHeight / 1.5
    }
}


// MARK:  Data Source
extension ViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        cell.pImageView.image = viewModel.cellViewModels[indexPath.row].image
        return cell
    }
    
}
