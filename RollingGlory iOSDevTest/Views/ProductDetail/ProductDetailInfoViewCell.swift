//
//  ProductDetailInfoViewCell.swift
//  RollingGlory iOSDevTest
//
//  Created by Bayu Febry Asmoro on 30/6/19.
//  Copyright © 2019 Bayu Febry Asmoro. All rights reserved.
//

import UIKit

protocol ProductDetailInfoDelegate {
    func ProductDetailInfoWishlistButtonTapped(cell: ProductDetailInfoViewCell)
    func ProductDetailInfoExpandInfoButtonTapped(cell: ProductDetailInfoViewCell)
}

class ProductDetailInfoViewCell: UITableViewCell {

    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var wishlistImageView: UIImageView!
    @IBOutlet weak var productInfoLabel: UILabel!
    @IBOutlet weak var seeAllButton: UIButton!
    
    var delegate: ProductDetailInfoDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
    
    // MARK : - Actions
    
    @IBAction func wishlistButtonTapped(_ sender: Any) {
        guard let delegate = delegate else { return }
        
        delegate.ProductDetailInfoWishlistButtonTapped(cell: self)
    }
    
    @IBAction func expandInfoButtonTapped(_ sender: UIButton) {
        guard let delegate = delegate else { return }
        
        delegate.ProductDetailInfoExpandInfoButtonTapped(cell: self)
    }
}
