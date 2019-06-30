//
//  ProductDetailActionViewCell.swift
//  RollingGlory iOSDevTest
//
//  Created by Bayu Febry Asmoro on 30/6/19.
//  Copyright © 2019 Bayu Febry Asmoro. All rights reserved.
//

import UIKit

protocol ProductDetailActionDelegate {
    func ProductDetailActionMinusButtonTapped(cell: ProductDetailActionViewCell)
    func ProductDetailActionPlusButtonTapped(cell: ProductDetailActionViewCell)
    func ProductDetailActionAddToCartButtonTapped(cell: ProductDetailActionViewCell)
    func ProductDetailActionRedeemButtonTapped(cell: ProductDetailActionViewCell)
}

class ProductDetailActionViewCell: UITableViewCell {

    @IBOutlet weak var containerTotalView: UIView!
    @IBOutlet weak var totalItemLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var redeemButton: UIButton!
    
    var delegate: ProductDetailActionDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerTotalView.customCorner(radius: 21.0)
        containerTotalView.customBorder(width: 1.0, color: UIColor.rgAthensGray)
        
        addToCartButton.customCorner(radius: 21.0)
        addToCartButton.customBorder(width: 1.0, color: UIColor.rgLimaGreen)
        
        redeemButton.customCorner(radius: 21.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Actions
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        guard let delegate = delegate else { return }
        delegate.ProductDetailActionMinusButtonTapped(cell: self)
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        guard let delegate = delegate else { return }
        delegate.ProductDetailActionPlusButtonTapped(cell: self)
    }
    
    @IBAction func addToCartButtonTapped(_ sender: UIButton) {
        guard let delegate = delegate else { return }
        delegate.ProductDetailActionAddToCartButtonTapped(cell: self)
    }
    
    @IBAction func redeemButtonTapped(_ sender: UIButton) {
        guard let delegate = delegate else { return }
        delegate.ProductDetailActionRedeemButtonTapped(cell: self)
    }
}
