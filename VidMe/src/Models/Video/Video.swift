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
    var datePublished: Date?
    var likesCount: Int?
    var videoURL: String?
    var imageURL: String?
    var image: UIImage?
}

extension Video {

    static func create(_ id: String, _ name: String?, _ datePublished: Date?, _ likesCount: Int?, _ videoURL: String? , _ imageURL: String?, _ image: UIImage? = nil) -> Video {
        return Video(id: id, name: name, datePublished: datePublished, likesCount:likesCount, videoURL: videoURL, imageURL: imageURL, image: image)
    }
    
    static func parsJSON(_ json: [String: Any]?) -> [Video] {
        var videos = [Video]()
        
        if let json = json {
            let array = json["videos"] as! [[String: Any]]
            for item in array {
                let id = item["video_id"] as! String
                let name = item["title"] as! String
                
                let stringDate = item["date_published"] as! String
                let datePublished = Date.convertString(dateString: stringDate)
                
                let likesCount = item["likes_count"] as! Int
                let videoUrl = item["complete_url"] as! String
                let imageUrl = item["thumbnail_url"] as! String
                
                videos.append(Video.create(id, name, datePublished, likesCount, videoUrl, imageUrl))
            }
        }
        
        return videos
    }
}
