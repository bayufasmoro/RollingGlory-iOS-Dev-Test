//
//  ProductListCollectionViewController.swift
//  RollingGlory iOSDevTest
//
//  Created by Bayu Febry Asmoro on 30/6/19.
//  Copyright © 2019 Bayu Febry Asmoro. All rights reserved.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "Cell"

class ProductListCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var giftArr: [Gift]  = {
        return Array(Gift.currentGift(realm: Service.shared.realm))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Collectionview setups
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        // Register cell classes
        self.collectionView!.registerNIBForCell(with: ProductListItemCollectionViewCell.self)
        
        loadRemoteData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide navigation bar
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        giftArr = Array(Gift.currentGift(realm: Service.shared.realm))
        self.collectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Unhide navigation bar
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - Helpers
    
    func loadRemoteData() {
        
        DejalBezelActivityView.addActivityView(for: self.view)
        Service.shared.getGift { (result, error) in
            DejalBezelActivityView.remove(animated: true)
            
            if let result = result as? [Gift] {
                self.giftArr = result
                self.collectionView.reloadData()
            } else {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return giftArr.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: ProductListItemCollectionViewCell.self, for: indexPath)!
    
        let gift = giftArr[indexPath.item]
        
        cell.delegate = self
        
        cell.productLoadingIndicator.startAnimating()
        cell.productImageView.kf.setImage(with: URL(string: gift.image), placeholder: nil, options: nil, progressBlock: nil) { (result) in
            cell.productLoadingIndicator.stopAnimating()
        }
        
        cell.badgeImageView.isHidden = !gift.isNew
        cell.productNameLabel.text = gift.name
        cell.pointLabel.text = "\(gift.points) points"
        cell.reviewLabel.text = "\(gift.numReviews) reviews"
        
        let rating = Int(gift.rating.rounded(.down))
        cell.setRating(with: rating)
        
        let wishlistImage = (gift.isWishlist) ? "ic_wishlist_click" : "ic_wishlist"
        cell.wishlistButton.setImage(UIImage(named: wishlistImage), for: .normal)
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gift = giftArr[indexPath.item]
        
        let vc = ProductDetailTableViewController()
        vc.gift = gift
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screen = UIScreen.main.bounds.size
        return CGSize(width: (screen.width-60)/2, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}

extension ProductListCollectionViewController: ProductListItemDelegate {
    
    // MARK: - Tableview delegates
    
    func ProductListItemWishlistButtonTapped(cell: ProductListItemCollectionViewCell) {
        
        guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
        let gift = giftArr[indexPath.item]
        
        let wishlistStatus = !gift.isWishlist
        Gift.updateWishlistObject(with: wishlistStatus, withData: gift, inRealm: Service.shared.realm)
        
        self.collectionView.reloadItems(at: [indexPath])
        
        if wishlistStatus {
            let alert = UIAlertController(title: "Success", message: "Added to wishlist", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
