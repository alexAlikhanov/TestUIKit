//
//  UserDefaultsManager.swift
//  Pet-1
//
//  Created by Алексей on 11/15/22.
//

import Foundation

class UserDefaultsManager {
    
    static var shared = UserDefaultsManager()
    var userDefaultsKey = "myTracks"
    
    func save(_ tracks: [Track]){
        let data = try? JSONEncoder().encode(tracks)
        UserDefaults.standard.set(data, forKey: userDefaultsKey)
    }
    
    func loadData(forKey: String, complition: @escaping ([Track]) -> Void) {
        guard let data = UserDefaults.standard.data(forKey: forKey) else { return }
        do {
            let traks = try JSONDecoder().decode([Track].self, from: data)
            complition(traks)
        } catch {
            
        }
        
    }
}
