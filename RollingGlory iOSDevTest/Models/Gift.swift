//
//  Gift.swift
//  RollingGlory iOSDevTest
//
//  Created by Bayu Febry Asmoro on 30/6/19.
//  Copyright © 2019 Bayu Febry Asmoro. All rights reserved.
//

import RealmSwift

class Gift: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var info: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var points: Int = 0
    @objc dynamic var stock: Int = 0
    @objc dynamic var image: String = ""
    @objc dynamic var isNew: Bool = false
    @objc dynamic var slug: String = ""
    @objc dynamic var rating: Double = 0
    @objc dynamic var numReviews: Int = 0
    @objc dynamic var lastUpdate: Date = Date()
    @objc dynamic var isDeleted: Bool = false
    @objc dynamic var isWishlist: Bool = false
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    class func currentGift(realm: Realm) -> Results<Gift> {
        let data = realm.objects(Gift.self)
        return data
    }
    
    class func insertObject(dictionary: [String:Any]) -> Gift {
        let this = Gift()
        
        if let data = dictionary["id"] as? Int {
            this.id = data
        }
        if let data = dictionary["name"] as? String {
            this.name = data
        }
        if let data = dictionary["info"] as? String {
            this.info = data
        }
        if let data = dictionary["description"] as? String {
            this.desc = data
        }
        if let data = dictionary["points"] as? Int {
            this.points = data
        }
        if let data = dictionary["stock"] as? Int {
            this.stock = data
        }
        if let data = dictionary["image"] as? String {
            this.image = data
        }
        if let data = dictionary["isNew"] as? Bool {
            this.isNew = data
        }
        if let data = dictionary["slug"] as? String {
            this.slug = data
        }
        if let data = dictionary["rating"] as? String {
            this.rating = Double(data) ?? 0
        }
        if let data = dictionary["num_reviews"] as? Int {
            this.numReviews = data
        }
        
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let data = dictionary["lastUpdate"] as? String {
            this.lastUpdate = formatter.date(from: data) ?? Date()
        }
        if let data = dictionary["isDeleted"] as? Bool {
            this.isDeleted = data
        }
        
        this.isWishlist = false
        
        do {
            let realm = try! Realm()
            try realm.write { realm.add(this, update: true) }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return this
    }
    
    class func updateWishlistObject(with isWishlist: Bool, withData data: Gift, inRealm realm: Realm) {
        
        do {
            try realm.write {
                data.isWishlist = isWishlist
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
