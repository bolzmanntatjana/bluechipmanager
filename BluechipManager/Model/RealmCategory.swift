//
//  RealmCategory.swift
//  BluechipManager
//
//  Created by admin on 6/25/24.
//



import Foundation
import RealmSwift


class RealmCategory:  Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var name: String = ""
}
