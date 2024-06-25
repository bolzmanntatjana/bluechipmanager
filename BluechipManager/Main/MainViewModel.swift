//
//  MainViewModel.swift
//  BluechipManager
//
//  Created by admin on 6/25/24.
//



import SwiftUI

class MainViewModel: ObservableObject {
    
    @Published var walletList: [RealmWallet] = []
    @Published var selectedWallet = RealmWallet()

    @Published var selectedWalletName: String = ""
    @Published var trans: [RealmWalTrans] = []
    @Published var values: [Double] = []
    @Published var total: Double = 0
    
    func getAllWallets() {
        walletList = StorageManager.shared.getWalletList()
    }
    
    func getFirstList() {
        if let wallet = walletList.first {
            selectedWallet = wallet
            selectedWalletName = wallet.name
        }
       
    }
    
    func getWallet() {
        for wallet in walletList {
            if wallet.name == selectedWalletName {
                selectedWallet = wallet
            }
        }
    }
    
    func getAllTrans() {
        for wallet in walletList {
            if wallet.name == selectedWalletName {
                trans = Array(wallet.trans)
            }
        }
    }
    
    func calculateTotalAndValues() {
        total = 0
        values = []

        for transaction in trans {
            let value = transaction.transType == "income" ? transaction.transValue : -transaction.transValue
            total += value
            values.append(value)
        }
    }

}
