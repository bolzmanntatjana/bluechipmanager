//
//  NetworkManager.swift
//  BluechipManager
//
//  Created by admin on 6/25/24.
//



import Foundation


class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init(){}
    
    func getCurrencyNews(fromCurrency: String, toCurrency: String, completion: @escaping (CurrencyNews?, Error?) -> Void) {
        let headers = [
            "x-rapidapi-key": "d3513b6408msh8612b4aa4be1472p193729jsn686988db978a",
            "x-rapidapi-host": "real-time-finance-data.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://real-time-finance-data.p.rapidapi.com/currency-news?from_symbol=\(fromCurrency)&language=en&to_symbol=\(toCurrency)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            guard response is HTTPURLResponse else {
                completion(nil, NSError(domain: "HTTPError", code: -1, userInfo: nil))
                print("Response error")
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "NoData", code: -1, userInfo: nil))
                print("Data error")
                return
            }
            
            do {
                let news = try JSONDecoder().decode(CurrencyNews.self, from: data)
                completion(news, nil)
            } catch {
                print("Decoder error: \(error.localizedDescription)")
                completion(nil, error)
            }
        }

        dataTask.resume()
    }
    
    func getNews(completion: @escaping (FinanceNews?, Error?) -> Void) {
        let headers = [
            "x-rapidapi-key": "d3513b6408msh8612b4aa4be1472p193729jsn686988db978a",
            "x-rapidapi-host": "real-time-finance-data.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://real-time-finance-data.p.rapidapi.com/stock-news?symbol=AAPL%3ANASDAQ&language=en")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            guard response is HTTPURLResponse else {
                completion(nil, NSError(domain: "HTTPError", code: -1, userInfo: nil))
                print("Response error")
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "NoData", code: -1, userInfo: nil))
                print("Data error")
                return
            }
            
            do {
                let news = try JSONDecoder().decode(FinanceNews.self, from: data)
                completion(news, nil)
            } catch {
                print("Decoder error: \(error.localizedDescription)")
                completion(nil, error)
            }
        }

        dataTask.resume()
    }
    
}
