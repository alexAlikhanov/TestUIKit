//
//  PhotoModel.swift
//  Pet-1
//
//  Created by Алексей on 11/12/22.
//

import Foundation

class PhotoModel: Codable {
    
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
}
