//
//  Item.swift
//  Todoey
//
//  Created by Letitia Wu on 2019/10/5.
//  Copyright © 2019 Letitia Wu. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}

