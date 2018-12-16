//
//  Item.swift
//  Todoey
//
//  Created by gayan perera on 12/16/18.
//  Copyright © 2018 gayan perera. All rights reserved.
//

import Foundation
import RealmSwift

class Item:Object {
    @objc dynamic var item:String?
    @objc dynamic var done:Bool = false
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
