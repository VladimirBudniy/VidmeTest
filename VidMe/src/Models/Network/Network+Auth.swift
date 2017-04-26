//
//  Network+Auth.swift
//  VidMe
//
//  Created by Vladimir Budniy on 4/26/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import Alamofire

typealias userCreate = (Bool) -> ()

let const = AuthConst()

func createAuthenticationSession(_ login: String, _ password: String, _ bool:@escaping userCreate){
    if let url = URL(string: UsersPaths().create) {
        let parameters = [const.username: login, const.password: password]
        
        Alamofire.request(url,
                          method: .post,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON(completionHandler: { response in
                            if let JSON = response.value, response.error == nil {
                                let json = JSON as! [String: Any]
                                let auth = json[const.auth] as! [String: Any]
                                let token = auth[const.token] as! String
                                let user_id = auth[const.user_id] as! String
                                
                                userDefaults.set(login, forKey: const.username)
                                userDefaults.set(password, forKey: const.password)
                                userDefaults.set(token, forKey: const.token)
                                userDefaults.set(user_id, forKey: const.user_id)
                                
                                bool(true)
                            }
                            
                            if response.error != nil {
                                bool(false)
                            }
                          })
    }
}

func checkAuthenticationSession() {
    if let token = userDefaults.value(forKey: const.token) {
        if let url = URL(string: UsersPaths().check) {
            let currentToken = token as! String
            
            let parameters = [const.token: currentToken]
            let headers = [const.AccessToken: currentToken]
            
            Alamofire.request(url,
                              method: .post,
                              parameters: parameters,
                              encoding: JSONEncoding.default,
                              headers: headers).responseJSON(completionHandler: { response  in
                                let json = response.value as! [String: Any]
                                print(json)
                              })
        }
    }
}

