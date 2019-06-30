//
//  Service.swift
//  RollingGlory iOSDevTest
//
//  Created by Bayu Febry Asmoro on 30/6/19.
//  Copyright © 2019 Bayu Febry Asmoro. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

typealias CompletionHandler = (_: Any?, _: NSError?) -> ()

class Service: NSObject {
    
    /// Shared Service
    class var shared: Service {
        
        struct Static {
            static let instance: Service = Service()
        }
        
        return Static.instance
    }
    
    // Vars
    let realm = try! Realm()
    
    let rgBaseUrl = "https://recruitment.dev.rollingglory.com/"
    let rgGiftEndpoint = "mapi/gift"
    
    override init() {
        super.init()
    }
}

// MARK: - API
extension Service {
    func getGift(completion: @escaping CompletionHandler) {
        
        Alamofire.request(rgBaseUrl + rgGiftEndpoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            if let responseValue = response.result.value as? [String: Any] {
                
                let statusCode = responseValue["status"] as? Int
                let message = responseValue["message"] as? String
                
                if statusCode == 200, let data = responseValue["data"] as? [String: Any], let giftArr = data["gifts"] as? [[String: Any]] {
                    
                    var gifts = [Gift]()
                    for gift in giftArr {
                        gifts.append(Gift.insertObject(dictionary: gift))
                    }
                    
                    completion(gifts, nil)
                } else {
                    completion(nil, NSError(domain: message ?? "", code: 101, userInfo: nil))
                }
            } else if let error = response.result.error {
                completion(nil, error as NSError?)
            } else {
                completion(nil, nil)
            }
        }
    }
}
