//
//  Converter.swift
//  BluechipManager
//
//  Created by admin on 6/25/24.
//

import Foundation

// MARK: - Converter
struct Converter: Codable {
    let date: String
    let info: Info
    let query: Query
    let result: Double
    let success: Bool
}

// MARK: - Info
struct Info: Codable {
    let rate: Double
    let timestamp: Int
}

// MARK: - Query
struct Query: Codable {
    let amount: Int
    let from, to: String
}
