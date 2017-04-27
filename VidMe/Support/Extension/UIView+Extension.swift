//
//  UIView+Extension.swift
//  VidMe
//
//  Created by Vladimir Budniy on 4/25/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    func show(_ spinner: inout SpinnerView?) {
        var view = spinner
        if view == nil {
            view = SpinnerView.loadSpinner()
            view?.spinner?.color = UIColor.white
            spinner = view
            view?.frame = self.frame
            view?.spinner?.startAnimating()
        }
        
        UIView.animate(withDuration: 0.4, animations: {
            view?.alpha = 0.3
            self.addSubview(view!)
        })
    }
    
    func remove(_ spinner: inout SpinnerView?) {
        let view = spinner
        UIView.animate(withDuration: 0.4, animations: {
            view?.alpha = 0.0
        }, completion: { loaded in
            if loaded {
                view?.removeFromSuperview()
                view?.spinner?.stopAnimating()
            }
        })
        
        spinner = nil;
    }
    
}
