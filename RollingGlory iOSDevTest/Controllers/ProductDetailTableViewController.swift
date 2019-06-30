//
//  ProductDetailTableViewController.swift
//  RollingGlory iOSDevTest
//
//  Created by Bayu Febry Asmoro on 30/6/19.
//  Copyright © 2019 Bayu Febry Asmoro. All rights reserved.
//

import UIKit
import Kingfisher

class ProductDetailTableViewController: UITableViewController {
    
    var cellHeights: [IndexPath : CGFloat] = [:]
    
    var gift: Gift = Gift()
    var isInfoExpanded = false
    var totalItem = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation setup
        self.title = "Gift detail"
        let backButton = UIBarButtonItem(image: UIImage(named: "ic_back"),
                                      style: .plain,
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backButton
        
        // Tableview setup
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        // Register cell classes
        self.tableView.registerNIB(with: ProductDetailHeaderViewCell.self)
        self.tableView.registerNIB(with: ProductDetailInfoViewCell.self)
        self.tableView.registerNIB(with: ProductDetailActionViewCell.self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueCell(with: ProductDetailHeaderViewCell.self)!
            
            cell.productLoadingIndicator.startAnimating()
            cell.productImageView.kf.setImage(with: URL(string: gift.image), placeholder: nil, options: nil, progressBlock: nil) { (result) in
                cell.productLoadingIndicator.stopAnimating()
            }
            
            cell.badgeImageView.isHidden = !gift.isNew
            cell.productNameLabel.text = gift.name
            cell.productDescLabel.text = nil
            
            return cell
        case 1:
            let cell = tableView.dequeueCell(with: ProductDetailInfoViewCell.self)!
            
            cell.delegate = self
            
            cell.pointLabel.text = "\(gift.points)"
            cell.reviewLabel.text = "\(gift.numReviews)\nreviews"
            
            let rating = Int(gift.rating.rounded(.down))
            cell.setRating(with: rating)
            
            let wishlistImage = (gift.isWishlist) ? "ic_wishlist_click" : "ic_wishlist"
            cell.wishlistImageView.image = UIImage(named: wishlistImage)
            
            if isInfoExpanded {
                cell.productInfoLabel.text = gift.desc.html2String
                cell.seeAllButton.setTitle("Lihat lebih sedikit", for: .normal)
            } else {
                cell.productInfoLabel.text = gift.info.html2String
                cell.seeAllButton.setTitle("Lihat semua", for: .normal)
            }
            
            return cell
        default:
            let cell = tableView.dequeueCell(with: ProductDetailActionViewCell.self)!
            
            cell.delegate = self
            cell.totalItemLabel.text = "\(totalItem)"
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Save cells height to variable
        cellHeights[indexPath] = cell.frame.size.height
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        // Load cells height to variable
        return cellHeights[indexPath] ?? 44.0
    }
}

extension ProductDetailTableViewController: ProductDetailInfoDelegate, ProductDetailActionDelegate {
    
    // MARK: - ProductDetailInfoDelegate
    
    func ProductDetailInfoWishlistButtonTapped(cell: ProductDetailInfoViewCell) {
        
        let wishlistStatus = !gift.isWishlist
        Gift.updateWishlistObject(with: wishlistStatus, withData: gift, inRealm: Service.shared.realm)
        
        guard let indexPath = self.tableView.indexPath(for: cell) else { return }
        self.tableView.reloadRows(at: [indexPath], with: .none)
        
        if wishlistStatus {
            let alert = UIAlertController(title: "Success", message: "Added to wishlist", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func ProductDetailInfoExpandInfoButtonTapped(cell: ProductDetailInfoViewCell) {
        
        isInfoExpanded = !isInfoExpanded
        
        guard let indexPath = self.tableView.indexPath(for: cell) else { return }
        self.tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    // MARK: - ProductDetailActionDelegate
    
    func ProductDetailActionMinusButtonTapped(cell: ProductDetailActionViewCell) {
        guard totalItem != 1 else { return }
        
        totalItem -= 1
        cell.totalItemLabel.text = "\(totalItem)"
    }
    
    func ProductDetailActionPlusButtonTapped(cell: ProductDetailActionViewCell) {
        totalItem += 1
        cell.totalItemLabel.text = "\(totalItem)"
    }
    
    func ProductDetailActionAddToCartButtonTapped(cell: ProductDetailActionViewCell) {
        let alert = UIAlertController(title: "Success", message: "Added to cart", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func ProductDetailActionRedeemButtonTapped(cell: ProductDetailActionViewCell) {
        let alert = UIAlertController(title: "Success", message: "Product redeemed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
