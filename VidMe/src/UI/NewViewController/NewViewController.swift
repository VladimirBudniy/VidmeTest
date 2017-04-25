//
//  NewViewController.swift
//  VidMe
//
//  Created by Vladimir Budniy on 4/25/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit

class NewViewController: ListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func load() {
        loadVideos(URLPaths().new, videosBlock: self.reloadViewWith, errorBlock: self.loadError)
    }
    
    // MARK: - Blocks methods
    
    override func loadError(error: String) {
        self.tableView?.refreshControl?.endRefreshing()
        self.showAlertController(title: "", message: error)
    }
    
    override func reloadViewWith(_ videos: [Video]) {
        if videos.count != 0 {
            self.videos.append(contentsOf: videos)
            self.tableView?.reloadData()
            self.tableView.remove(&self.spinner)
            self.tableView?.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! ListViewCell
        cell.fillWithModel(self.videos[indexPath.row], tableView)
        tableView.rowHeight = cell.frame.height
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
