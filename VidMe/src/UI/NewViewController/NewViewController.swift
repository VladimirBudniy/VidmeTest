//
//  NewViewController.swift
//  VidMe
//
//  Created by Vladimir Budniy on 4/25/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit

class NewViewController: FeaturedViewController {
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForLoad(_ offset: Int) {
        let parameters = [const.offset: offset, const.limit: self.videoLimit]
        loadVideos(URLPaths().new, parameters, self.loadList, self.loadError)
    }
}
