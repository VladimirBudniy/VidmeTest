//
//  Video.swift
//  VidMe
//
//  Created by Vladimir Budniy on 4/25/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation

struct Video {
    var id: String?
    var name: String?
    var videoURL: String?
    var imageURL: String?
}

extension Video {

    func createVideo(_ id: String, _ name: String?, _ videoURL: String? , _ imageURL: String? ) -> Video {
        return Video(id: id, name: name, videoURL: videoURL, imageURL: imageURL)
    }
    
    
    
}
