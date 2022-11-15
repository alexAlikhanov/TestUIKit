//
//  NetworkDataFetcher.swift
//  Pet-1
//
//  Created by Алексей on 11/15/22.
//

import Foundation
import UIKit

class NetworkDataFetcher {
    
    let networkService = NetworkService()
    
    func fetchTracks(urlString: String, response: @escaping (SearchResponse?) -> Void){
        networkService.request(urlString: urlString) { (result) in
            switch result{
            case .success(let data):
                do {
                    let tracks = try JSONDecoder().decode(SearchResponse.self, from: data)
                    print("json ok")
                    response(tracks)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
    
    func fetchAlbumImage(imageUrlString: String?, response: @escaping (UIImage?) -> Void){
        guard let safeImageUrlString = imageUrlString else { return }
        networkService.request(urlString: safeImageUrlString) { (result) in
            switch result{
            case .success(let data):
                let image = UIImage(data: data)
                response(image)
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
}
