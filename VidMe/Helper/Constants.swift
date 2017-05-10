//
//  Constants.swift
//  VidMeTest
//
//  Created by Vladimir Budniy on 4/25/17.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

import Foundation

struct URLPaths {
    let featured = "https://api.vid.me/videos/featured"
    let new = "https://api.vid.me/videos/new"
    let following = "https://api.vid.me/videos/following"
}

struct UsersPaths {
    let create = "https://api.vid.me/auth/create"
    let check = "https://api.vid.me/auth/check"
    let delete = "https://api.vid.me/auth/delete"
}

struct CheckEmailRange {
//    let emailRange = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailRange = "[A-Za-z0-9]"
}

struct AlertControllerConst {
    let emailMessage = "Please check your email"
    let whitespaceMessage = "Please remove whitespace"
    let charactersQty = "Password must be at least 8 characters"
    let erroValidation = "Please сheck specified data"
    let userNotFound = "User with specified name not found or check internet connection"
}

struct AuthConst {
    let username = "username"
    let password = "password"
    let auth = "auth"
    let token = "token"
    let user_id = "user_id"
    let AccessToken = "AccessToken"
    let offset = "offset"
    let limit = "limit"
}
