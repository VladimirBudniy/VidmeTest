//
//  ListViewController.swift
//  VidMe
//
//  Created by Vladimir Budniy on 4/25/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController, AlertViewController {
    
    let alertViewController = UIAlertController()
    let identifier = String(describing: ListViewCell.self)
    var videos = [Video]()
    var spinner: SpinnerView?

    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.settingTableVie()
        
        loadVideos(URLPaths().featured, videosBlock: self.reloadViewWith, errorBlock: self.loadError)
    
    }
    
    // MARK: - Private
    
    fileprivate func settingTableVie() {
        let tableView = self.tableView
        tableView?.contentInset.top = 20
        tableView?.show(&self.spinner)
        
        self.addRefreshControl()
    }
    
    private func showAlertController(title: String? = nil, message: String) {
        self.present(self.alertViewController(title: title, message: message), animated: true, completion: nil)
    }
    
    // MARK: - Blocks methods
    
    private func loadError(error: String) {
        self.tableView?.refreshControl?.endRefreshing()
        self.showAlertController(title: "", message: error)
    }
    
    private func reloadViewWith(_ videos: [Video]) {
        if videos.count != 0 {
            self.videos.append(contentsOf: videos)
            self.tableView?.reloadData()
            self.tableView.remove(&self.spinner)
            self.tableView?.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: - UIRefreshControl
    
    private func addRefreshControl() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshLoad), for: .valueChanged)
        self.tableView.refreshControl = refresh
    }
    
    @objc private func refreshLoad() {

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
