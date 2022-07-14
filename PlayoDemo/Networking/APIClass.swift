//
//  APIClass.swift
//  PlayoDemo
//
//  Created by Dev iOS on 7/14/22.
//

import Foundation

class APIClass {
    
    func CallAPI(_ completion: @escaping (Data?, Error?) ->()){
        let Url = String(format: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=56f88447160147448780a37142b95124")
        guard let serviceUrl = URL(string: Url) else { return }
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                completion(data, nil)
                print(response)
            }else {
                print(error! as NSError)
                completion(nil, error)
            }
        }.resume()
    }
    
}
