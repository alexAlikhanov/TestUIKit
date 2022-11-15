//
//  NetworkManager.swift
//  Pet-1
//
//  Created by Алексей on 11/11/22.
//

import Foundation
import UIKit

class NetworkManager{
    
    enum HTTPMethod: String {
        case POST
        case PUT
        case GET
        case DELETE
    }
    
    enum APIs: String {
        case posts
        case users
        case photos
        case comments
    }
    
    
    let baseURL = "https://jsonplaceholder.typicode.com/"

    func getAllPosts(_ complitionHandler: @escaping ([PostModel]) -> Void){
        
        if let url = URL(string: baseURL + APIs.posts.rawValue){
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    print("Error download posts")
                } else {
                    if let resp = response as? HTTPURLResponse,
                       resp.statusCode == 200,
                       let responseData = data {
                        var posts = try? JSONDecoder().decode([PostModel].self, from: responseData)
                        posts?.shuffle()
                        complitionHandler(posts ?? [])
                    }
                }
            }.resume()
        }
    }
    
    func getFirstPhotoInAlbumBy(id: Int, _ complitionHandler: @escaping (Data) -> Void){
        if let url = URL(string: baseURL + APIs.photos.rawValue +  "?albumId=\(id)&id=\(id * 50 - 49)"){
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    print("Error download posts")
                } else {
                    if let resp = response as? HTTPURLResponse,
                       resp.statusCode == 200,
                       let responseData = data {
                        let photo = try? JSONDecoder().decode([PhotoModel].self, from: responseData)
                        let imageURL = URL(string: (photo?[0].url)!)!
                        let task = URLSession.shared.dataTask(with: imageURL) { data, response , error  in
                            if let imageData = data {
                                complitionHandler(imageData)
                            }
                        }
                        task.resume()
                    }
                }
            }.resume()
        }
    }
    
    
    func loadImage(imageUrl: URL, complitionHandler: @escaping (UIImage?, Error?) -> Void) {
        let queue = DispatchQueue.global()
        queue.async {
            do {
                let data = try Data(contentsOf: imageUrl)
                DispatchQueue.main.async {complitionHandler(UIImage(data: data), nil)}
            }
            catch let error {
                DispatchQueue.main.async {complitionHandler(nil, error)
                }
            }
        }
    }
    
    func serchById(_ items: [PhotoModel], id x: Int ) -> [PhotoModel]?{
        var returnArray = [PhotoModel]()
        var i = 0
        let count = items.count
        while i < count {
            if items[i].albumId == x {
                returnArray.append(items[i])
            }
            i += 1
        }
        if returnArray.count < 1 {
            return nil
        } else {
            return returnArray
        }
    }
    
}
        
