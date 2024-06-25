//
//  ConversionManager.swift
//  BluechipManager
//
//  Created by admin on 6/25/24.
//


import Foundation


class ConversionManager {
    
    static let shared = ConversionManager()
    
    private init(){}
    
    func convert(_ value: String, from first: String, to second: String, completion: @escaping (Converter?, Error?) -> Void) {
        let headers = [
            "X-RapidAPI-Key": "a5f7043fcfmsh3f30e4ac2f79e5bp15b354jsn5545e9f1bc84",
            "X-RapidAPI-Host": "currency-conversion-and-exchange-rates.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://currency-conversion-and-exchange-rates.p.rapidapi.com/convert?from=\(first)&to=\(second)&amount=\(value)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print("Error \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            guard let _ = response as? HTTPURLResponse else {
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
                let recievedData = try JSONDecoder().decode(Converter.self, from: data)
                completion(recievedData, nil)
            } catch {
                print("Decoder error: \(error.localizedDescription)")
                completion(nil, error)
            }
        })

        dataTask.resume()
    }
    
}
