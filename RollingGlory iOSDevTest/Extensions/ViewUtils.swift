//
//  ViewUtils.swift
//  RollingGlory iOSDevTest
//
//  Created by Bayu Febry Asmoro on 30/6/19.
//  Copyright © 2019 Bayu Febry Asmoro. All rights reserved.
//

import UIKit

extension UITableView {
    func registerNIB(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }
    
    func dequeueCell<T>(with cellClass: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: cellClass)) as? T
    }
}

extension UICollectionView {
    func registerNIBForCell(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        self.register(UINib(nibName: className, bundle: nil), forCellWithReuseIdentifier: className)
    }
    
    func dequeueCell<T>(with cellClass: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: String(describing: cellClass), for: indexPath) as? T
    }
}
