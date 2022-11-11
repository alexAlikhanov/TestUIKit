//
//  NetworkManager.swift
//  Pet-1
//
//  Created by Алексей on 11/11/22.
//

import Foundation

class NetworkManager{
    
    func getAllPosts(_ complitionHandler: @escaping ([PostModel]) -> Void){
        
        if let url = URL(string: "https://jsonplaceholder.typicode.com/posts"){
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    print("Error download posts")
                } else {
                    if let resp = response as? HTTPURLResponse,
                       resp.statusCode == 200,
                       let responseData = data {
                        let posts = try? JSONDecoder().decode([PostModel].self, from: responseData)
                        complitionHandler(posts ?? [])
                        print("ok")
                    }
                }
            }.resume()
        }
    }
}
