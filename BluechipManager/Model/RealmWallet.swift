//
//  RealmWallet.swift
//  BluechipManager
//
//  Created by admin on 6/25/24.
//



import Foundation
import RealmSwift


class RealmWallet:  Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var name: String = ""
    @Persisted var trans = RealmSwift.List<RealmWalTrans>()
}

class RealmWalTrans: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId

    @Persisted var transValue: Double = 0
    @Persisted var transCategory: String = ""
    @Persisted var transType: String = ""
    @Persisted var transNote: String = ""
    @Persisted var photoData: Data?
    @Persisted var transDate: Date

}


extension RealmWallet {
    static var example: RealmWallet {
        let list = RealmWallet()
        list.name = "New wallet"
        
        let transaction = RealmWalTrans()
        transaction.transValue = 1
        transaction.transCategory = "Slots"
        transaction.transType = "income"
        
        for _ in 1..<15 {
            list.trans.append(transaction)
        }
        
        return list
        
    }
}

extension RealmWalTrans {
    static var example: RealmWalTrans {
            let tr = RealmWalTrans()
            tr.transValue = 12
        tr.transType = "income"
        tr.transCategory = "Slots"
        tr.transDate = Date()
        tr.transNote = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. "
            return tr
        }
}
