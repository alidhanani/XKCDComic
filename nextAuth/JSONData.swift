//
//  JSONData.swift
//  nextAuth
//
//  Created by Ali Dhanani on 14/12/2020.
//

import Foundation

class JSONData {
    
    // Making Singelton
    static let shared = JSONData()
    
    private let httpsAddress = "https://xkcd.com/info.0.json"
    
    init() {
    }
    
    // Getting all the JSON data from the URL
    func getAllData(Handler: @escaping((Response?)->(Void))) {
        guard let url = URL(string: httpsAddress) else {return}
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, res, error) in
            if let data = data {
                do {
                    let responses = try JSONDecoder().decode(Response.self, from: data)
                    Handler(responses)
                } catch {
                    Handler(nil)
                }
            }
        }
        task.resume()
    }
    
}

