//
//  FeedViewController.swift
//  VidMe
//
//  Created by Vladimir Budniy on 4/26/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit

class FeedViewController: FeaturedViewController {

    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func load(offset: Int = 0, primaryLoad: Bool = true) {
        if primaryLoad {
            self.videos.removeAll()
            self.tableView.reloadData()

            let token = userDefaults.value(forKey: const.token) as! String
            
            let headers = [const.AccessToken: token] as [String: String]
            let parameters = [const.token: token, const.limit: 50] as [String : Any]
            
            loadVideos(URLPaths().following, parameters, headers: headers, self.loadList, self.loadError)
        } else {
            let parameters = [const.AccessToken: userDefaults.value(forKey: const.token), const.limit: self.videoLimit]
            loadVideos(URLPaths().following, parameters, self.loadList, self.loadError)
        }
    }
    
//    // MARK: - Blocks methods
//    
//    override func loadError(error: String) {
//        self.tableView?.refreshControl?.endRefreshing()
//        self.showAlertController(title: "", message: error)
//    }
//    
//    override func loadList(_ videos: [Video]) {
//        loadImages(videos, self.reloadViewWith, self.loadError)
//    }
//    
//    override func reloadViewWith(_ videos: [Video]) {
//        if videos.count != 0 {
//            self.tableView.remove(&self.spinner)
//            self.videos.append(contentsOf: videos)
//            self.tableView?.reloadData()
//            self.tableView?.refreshControl?.endRefreshing()
//        }
//    }
//
//    // MARK: - Table view data source
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.videos.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! FeaturedViewCell
//        cell.fillWithModel(self.videos[indexPath.row], tableView)
//        tableView.rowHeight = cell.frame.height
//        
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let stringURL = self.videos[indexPath.row].videoURL {
//            self.playVideo(stringURL)
//        }
//    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

    }

}
