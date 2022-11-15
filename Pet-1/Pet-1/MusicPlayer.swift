//
//  MusicPlayer.swift
//  Pet-1
//
//  Created by Алексей on 11/15/22.
//

import Foundation
import AVFAudio

class MusicPlayer {
    
    private var player = AVAudioPlayer()
    static let shared = MusicPlayer()
    private let networkService = NetworkService()
    
    
    func setupPlayer(stringURL: String?) {
        
        networkService.request(musicUrlString: stringURL) { [weak self] (result) in
            
            switch result{
            case .success(let data):
                do {
                    self?.player = try AVAudioPlayer(data: data, fileTypeHint: "m4a")
                    self?.player.play()
                } catch {
                    print("Error ")
                }
               
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                
            }
        }
    }

    func stop(){
        player.stop()
    }
}
