//
//  Video+Parser.swift
//  VidMe
//
//  Created by Vladimir Budniy on 4/25/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation

extension Video {
    static func parsJSON(_ json: [String: Any]?) -> [Video] {
        var videos = [Video]()
        
        if let json = json {
            let array = json["videos"] as! [[String: Any]]
            for item in array {
                let id = item["video_id"] as! String
                let name = item["title"] as! String
                let likesCount = item["likes_count"] as! Int
                let videoUrl = item["complete_url"] as! String
                let imageUrl = item["thumbnail_url"] as! String
                
                videos.append(Video.create(id, name, likesCount, videoUrl, imageUrl))
            }
        }
        
        return videos
    }
}
