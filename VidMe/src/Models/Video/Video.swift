//
//  Video.swift
//  VidMe
//
//  Created by Vladimir Budniy on 4/25/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import UIKit

struct Video {
    var id: String?
    var name: String?
    var likesCount: Int?
    var videoURL: String?
    var imageURL: String?
    var image: UIImage?
}

extension Video {

    static func create(_ id: String, _ name: String?, _ likesCount: Int?, _ videoURL: String? , _ imageURL: String?, _ image: UIImage? = nil) -> Video {
        return Video(id: id, name: name, likesCount:likesCount, videoURL: videoURL, imageURL: imageURL, image: image)
    }
    
    mutating func setImage(_ image: UIImage) {
        self.image = image
    }
    
}
