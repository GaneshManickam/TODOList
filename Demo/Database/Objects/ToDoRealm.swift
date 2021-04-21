//
//  ToDoRealm.swift
//  Demo
//
//  Created by Ganesh Manickam on 21/04/21.
//

import Foundation
import RealmSwift

class ToDoRealm: Object {
    var id = RealmOptional<Int>()
    var createdAt = RealmOptional<Double>()
    @objc dynamic var priority = ""
    @objc dynamic var title = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }

    convenience init(_ createdAt: Double, priority: String, title: String) {
        self.init()
        self.createdAt.value = createdAt
        self.id.value = Int(createdAt)
        self.priority = priority
        self.title = title
    }
}
