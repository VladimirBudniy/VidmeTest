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

func loadVideos(_ stringURL: String, videosBlock:@escaping videos,  errorBlock: @escaping error) {
    if let url = URL(string: stringURL) {
        let parameters = ["offset": 1, "limit": 4]
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
