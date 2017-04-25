//
//  AlertViewController.swift
//  VidMe
//
//  Created by Vladimir Budniy on 4/25/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import UIKit

public protocol AlertViewController {
    var alertViewController: UIAlertController { get }
}

public extension AlertViewController {
 
    func alertViewControllerWith(title: String?,
                                 message: String?,
                                 preferredStyle: UIAlertControllerStyle,
                                 actionTitle: String?,
                                 style: UIAlertActionStyle,
                                 handler:((UIAlertAction) -> Void)?) -> UIAlertController
    {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        let alertAction = UIAlertAction(title: actionTitle, style: style, handler: handler)
        alertView.addAction(alertAction)
        
        return alertView
    }
    
    func alertViewController(title: String? = nil, message: String, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        return alertViewControllerWith(title: title,
                                       message: message,
                                       preferredStyle: UIAlertControllerStyle.alert,
                                       actionTitle: "Ok",
                                       style: UIAlertActionStyle.default,
                                       handler: handler)
    }
}
