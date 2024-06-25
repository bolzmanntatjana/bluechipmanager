//
//  DataManager.swift
//  BluechipManager
//
//  Created by admin on 6/25/24.
//



import Foundation


class DataManager {
    
    static let shared = DataManager()
        
    private init(){}
    
    var cateogries: [String] = ["Housing", "Utilities", "Groceries", "Transportation", "Healthcare", "Insurance", "Dining Out", "Entertainment", "Clothing", "Education", "Personal Care", "Household Supplies", "Travel", "Subscriptions", "Gifts", "Pets", "Childcare", "Debt Payments", "Savings", "Miscellaneous", "Salary", "Bonus", "Freelance", "Investments", "Rental Income", "Dividends", "Interest", "Royalties", "Pension", "Social Security", "Child Support", "Alimony", "Government Benefits", "Business Income", "Tips", "Gifts Received", "Refunds", "Prizes", "Inheritance"]

    
    func createInit() {
        if !UserDefaults.standard.bool(forKey: "initial") {
            UserDefaults.standard.set(true, forKey: "initial")
            UserDefaults.standard.set("$", forKey: "currency")

            StorageManager.shared.createWallet(name: "Total")
            StorageManager.shared.createCategories(from: cateogries)
            
            print("Initial data created")
        }
        

    }
}
