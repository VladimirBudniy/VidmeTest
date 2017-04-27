//
//  Date+Extension.swift
//  VidMe
//
//  Created by Vladimir Budniy on 4/25/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation

let fullFormate = "yyyy-MM-dd HH:mm:ss"

extension Date {
    static func convertString(dateString: String?) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fullFormate
        guard let date = dateFormatter.date(from: dateString!) else {
            return Date()
        }
        
        return date
    }
}
