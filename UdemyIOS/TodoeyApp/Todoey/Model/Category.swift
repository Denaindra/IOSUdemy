//
//  .swift
//  Todoey
//
//  Created by gayan perera on 12/16/18.
//  Copyright © 2018 gayan perera. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name:String?
    let items = List<Item>()
}
