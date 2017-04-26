//
//  Network.swift
//  VidMe
//
//  Created by Vladimir Budniy on 4/25/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import Alamofire

typealias error = (String) -> ()
typealias videos = ([Video]) -> ()

func loadVideos(_ stringURL: String, _ videosBlock:@escaping videos, _ errorBlock: @escaping error) {
    if let url = URL(string: stringURL) {
        let parameters = ["offset": 1, "limit": 20]
        Alamofire.request(url,
                          method: .get,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON(completionHandler: { respons in
                            if let JSON = respons.value as? [String: Any], respons.result.isSuccess {
                                videosBlock(Video.parsJSON(JSON))
                            }
                            
                            if let error = respons.error {
                                errorBlock(error.localizedDescription)
                            }
                          })
    }
}

func loadImages(_ videos: [Video], _ videosBlock:@escaping videos, _ errorBlock: @escaping error) {
    let count = videos.count
    var listVideos = [Video]()
    for video in videos {
        if let imageURL = video.imageURL {
            let url = URL(string: imageURL)
            Alamofire.request(url!).responseData(completionHandler: { response in
                if let data = response.data, response.error == nil {
                    if let image = UIImage(data: data) {
                        var vid = video
                        vid.image = image
                        listVideos.append(vid)                        
                        if listVideos.count == count {
                           videosBlock(listVideos)
                        }
                    }
                }
            })
        }
    }
}
