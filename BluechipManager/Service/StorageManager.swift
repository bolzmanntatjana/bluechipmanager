//
//  StorageManager.swift
//  BluechipManager
//
//  Created by admin on 6/25/24.
//



import SwiftUI
import RealmSwift

class StorageManager {
    
    @ObservedResults(RealmWallet.self) var wallets
    @ObservedResults(RealmCategory.self) var categories
    
    static let shared = StorageManager()
    
    private init() {}
    
    let realm = try! Realm()
    
    func createCategories(from list: [String]) {
        

        for category in list {
            let newCategory = RealmCategory()
            newCategory.name = category
            $categories.append(newCategory)
        }
    }
    
    func removeData() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }
    
    func createWallet(name: String) {
        let new = RealmWallet()
        new.name = name
        $wallets.append(new)
    }
    
    func newsTrans(wallet: RealmWallet, value: Double, category: String, note: String, type: String, image: UIImage? ) {
                
        let trans = RealmWalTrans()
        trans.transNote = note
        trans.transType = type
        trans.transDate = Date()
        trans.transValue = value
        trans.transCategory = category
        
        if let photo = image {
            guard let data = photo.jpegData(compressionQuality: 1.0) else { return }
            trans.photoData = data
        } else {
            trans.photoData = nil
        }
        
        
        do {
            let walRef = ThreadSafeReference(to: wallet)
            
            try realm.write {
                guard let selectWal = realm.resolve(walRef) else { return }
                selectWal.trans.append(trans)
            }
        } catch {
            print("Error adding word: \(error.localizedDescription)")
        }
        
    }
    
    func getWalletList() -> [RealmWallet] {
        var wallets: [RealmWallet] = []
        for wallet in StorageManager.shared.wallets {
            wallets.append(wallet)
        }
        return wallets
    }
}
