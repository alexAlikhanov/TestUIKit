//
//  NetworkService.swift
//  Pet-1
//
//  Created by Алексей on 11/15/22.
//

import Foundation

class NetworkService {
    
    func request(urlString: String, complition: @escaping (Result<Data, Error>) -> Void){
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    complition(.failure(error))
                    return
                }
                guard let data = data else { return }
                complition(.success(data))
            }
        }.resume()
    }
    func request(imageUrlString: String, complition: @escaping (Result<Data, Error>) -> Void){
        
        guard let url = URL(string: imageUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    complition(.failure(error))
                    return
                }
                guard let data = data else { return }
                complition(.success(data))
            }
        }.resume()
    }
    func request(musicUrlString: String?, complition: @escaping (Result<Data, Error>) -> Void){
        
        guard let url = URL(string: musicUrlString!) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    complition(.failure(error))
                    return
                }
                guard let data = data else { return }
                complition(.success(data))
            }
        }.resume()
    }
}
