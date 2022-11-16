//
//  SearchResponce.swift
//  Pet-1
//
//  Created by Алексей on 11/15/22.
//

import Foundation

struct SearchResponse: Codable {
    var resultCount: Int
    var results: [Track]
}

struct Track: Codable {
    var artistName: String?
    var trackName: String?
    var collectionName: String?
    var previewUrl: String?
    var artworkUrl100: String?
    var trackTimeMillis: Int?
}
