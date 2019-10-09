//
//  Category.swift
//  Todoey
//
//  Created by Letitia Wu on 2019/10/5.
//  Copyright © 2019 Letitia Wu. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var colorValue : String = ""



    
    let items = List<Item>()
}
