//
//  ProductListItemCollectionViewCell.swift
//  RollingGlory iOSDevTest
//
//  Created by Bayu Febry Asmoro on 30/6/19.
//  Copyright © 2019 Bayu Febry Asmoro. All rights reserved.
//

import UIKit

protocol ProductListItemDelegate {
    func ProductListItemWishlistButtonTapped(cell: ProductListItemCollectionViewCell)
}

class ProductListItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var badgeImageView: UIImageView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var wishlistButton: UIButton!
    @IBOutlet weak var productLoadingIndicator: UIActivityIndicatorView!
    
    var delegate: ProductListItemDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.customCorner(radius: 4.0)
        containerView.customBorder(width: 1.0, color: UIColor.rgLightGray)
    }
    
    // MARK: - Helpers
    func setRating(with value:Int) {
        for i in 1...5 {
            let starImageView = ratingStackView.viewWithTag(i) as! UIImageView
            let starImage = UIImage(named: "ic_bintang")
            
            if i <= value {
                starImageView.image = starImage?.withRenderingMode(.alwaysOriginal)
            } else {
                starImageView.image = starImage?.withRenderingMode(.alwaysTemplate)
                starImageView.tintColor = UIColor.rgLightGray
            }
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func wishlistButtonTapped(_ sender: UIButton) {
        guard let delegate = delegate else { return }
        delegate.ProductListItemWishlistButtonTapped(cell: self)
    }
}
