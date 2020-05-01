//
//  Database.swift
//  AFCEA HI
//
//  Created by Kevin Chevalier on 4/18/20.
//  Copyright © 2020 AFCEA. All rights reserved.
//

import Foundation

class Database {
    static let urlBase = "https://brandonlester5.wixsite.com/afcea/_functions"
//    var body: some View {
//        List(results, id: \._id) { item in
//            VStack(alignment: .leading) {
//                Text(item.title)
//                    .font(.headline)
//                Text(item.description)
//            }
//        }
//        .onAppear(perform: loadData)
//    }
    
    static func loadData(_ events: Events){
        guard let url = URL(string: "\(urlBase)/events/") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                   let decodedResponse = try decoder.decode(Response.self, from: data)
                       // we have good data – go back to the main thread
                       DispatchQueue.main.async {
                           // update our UI
                            decodedResponse.updateEvents(events)
                       }

                       // everything is good, so we can exit
                       return
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            }else{
                print("Data is nil")
            }
        }.resume()
        return
    }
    
    static func send(_ json: Data, key: String){
        let urlString = "\(urlBase)/\(key)/"
        print("URL String '\(urlString)'")
        let url = URL(string:urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = json
        print("Sending Data to database!!")
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle the result here.
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
//            if let response = response{
//                print("Response:\(response)")
//            }
            
            if let error = error{
                print("Error: \(error)")
            }
            
            if data.count == 0{
                print("Data response is empty!")
                return
            }
            
            do {
                let dict = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                
                if let success = dict["success"] as? Bool{
                    print("Success: \(success)")
                }else{
                    print("Dictionary: \(dict)")
                }
            } catch {
                print("JSON ERROR: \(error.localizedDescription)")
            }
            
            
        }.resume()
    }
    
}
