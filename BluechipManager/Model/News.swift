//
//  News.swift
//  BluechipManager
//
//  Created by admin on 6/25/24.
//



import Foundation

// MARK: - FinanceNews
struct FinanceNews: Codable {
    let status, requestID: String
    let data: DataClass

    enum CodingKeys: String, CodingKey {
        case status
        case requestID = "request_id"
        case data
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let symbol, type: String
    let news: [News]
}

// MARK: - News
struct News: Codable, Hashable {
    let articleTitle: String
    let articleURL: String
    let articlePhotoURL: String
    let source, postTimeUTC: String

    enum CodingKeys: String, CodingKey {
        case articleTitle = "article_title"
        case articleURL = "article_url"
        case articlePhotoURL = "article_photo_url"
        case source
        case postTimeUTC = "post_time_utc"
    }
}

extension News {
    static let MOCK = News(articleTitle: "Buffett's first big semiconductor investment is a bet on Apple's future", articleURL: "https://www.cnbc.com/2022/11/19/buffetts-first-big-semiconductor-investment-is-a-bet-on-apples-future.html", articlePhotoURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTm_E16XvCVCiSgCDPLSW9pGpu245GtpzQat47IgtPgE6pVjFXBGzohJTv7F0A", source: "CNBC", postTimeUTC: "123123")
}



// MARK: - CurrencyNews
struct CurrencyNews: Codable {
    let status, requestID: String
    let data: CurrencyDataClass

    enum CodingKeys: String, CodingKey {
        case status
        case requestID = "request_id"
        case data
    }
}

// MARK: - DataClass
struct CurrencyDataClass: Codable {
    let fromSymbol, toSymbol, type: String
    let news: [CNews]

    enum CodingKeys: String, CodingKey {
        case fromSymbol = "from_symbol"
        case toSymbol = "to_symbol"
        case type, news
    }
}

// MARK: - News
struct CNews: Codable, Hashable {
    let articleTitle: String
    let articleURL: String
    let articlePhotoURL: String
    let source, postTimeUTC: String

    enum CodingKeys: String, CodingKey {
        case articleTitle = "article_title"
        case articleURL = "article_url"
        case articlePhotoURL = "article_photo_url"
        case source
        case postTimeUTC = "post_time_utc"
    }
}
