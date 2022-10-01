//
//  NewsManager.swift
//  News
//
//  Created by Gulyaz Huseynova on 12.09.22.
//

import UIKit

struct NewsManager {
    var success: ((NewsData?) -> Void)?
    var success2: ((NewsData?) -> Void)?
    
    
    func getRequest (info: String, lang: String) {
        //let lang = lang.lowercased()

        let info = info.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let string = "https://api.newscatcherapi.com/v2/search?q=\(info)&lang=\(lang)"
        let url = URL(string: string)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["x-api-key" : "x7qolMW2_nj7c_zKZ2ntcWcIB0QeYhhhcvnOclzz9Pw"]
        request.httpMethod = "GET"
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            if let e = error {
                print(e)
                return
            }
            if let safeData = data {
                let decodedData = try? JSONDecoder().decode(NewsData.self, from: safeData)
                self.success?(decodedData)

            }
        }
        session.resume()
    }
    
    func getRequestCollection (lang: String) {
        let string = "https://api.newscatcherapi.com/v2/search?q=finance&lang=\(lang)"
        let url = URL(string: string)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["x-api-key" : "mbBpw4mgT2cX0J43H4aTtKJag7VgwflaP8DZHtJR6rQ"]
        request.httpMethod = "GET"
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            if let e = error {
                print(e)
                return
            }
            if let safeData = data {
                let decodedData = try? JSONDecoder().decode(NewsData.self, from: safeData)
                self.success2?(decodedData)
                print("aaa", decodedData)
            }
        }
        session.resume()
    }
}
