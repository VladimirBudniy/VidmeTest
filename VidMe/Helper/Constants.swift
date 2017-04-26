//
//  Constants.swift
//  VidMeTest
//
//  Created by Nikola Andriiev on 24.11.16.
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
    let emailRange = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
}

struct AlertControllerConst {
    let emailMessage = "Please check your email"
    let whitespaceMessage = "Please remove whitespace"
//    let citiesQty = "The quantity of countries can't be more than 15 pcs!"
//    let cityNotFound = "Error: Not found city"
}
