//
//  BaseNavigationController.swift
//  RollingGlory iOSDevTest
//
//  Created by Bayu Febry Asmoro on 30/6/19.
//  Copyright © 2019 Bayu Febry Asmoro. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor.white
        navigationBar.backgroundColor = UIColor.white
        navigationBar.tintColor = UIColor.rgDarkBlue
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.rgRalewayRegular(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.rgDarkBlue
        ]
        
        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
        
        interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
