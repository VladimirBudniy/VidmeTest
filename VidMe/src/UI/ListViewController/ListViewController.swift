//
//  ListViewController.swift
//  VidMe
//
//  Created by Vladimir Budniy on 4/25/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ListViewController: UITableViewController, AlertViewController {
    
    let alertViewController = UIAlertController()
    let identifier = String(describing: ListViewCell.self)
    var videos = [Video]()
    var spinner: SpinnerView?

    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.settingTableView()
        self.load()
    }
    
    // MARK: - Private
    
    func load() {
        loadVideos(URLPaths().featured, self.loadList, self.loadError)
    }
    
    func settingTableView() {
        let tableView = self.tableView
        tableView?.contentInset.top = 20
        tableView?.show(&self.spinner)
        
        self.addRefreshControl()
    }
    
    func showAlertController(title: String? = nil, message: String) {
        self.present(self.alertViewController(title: title, message: message), animated: true, completion: nil)
    }
    
    // MARK: - Blocks methods
    
    func loadError(error: String) {
        self.tableView?.refreshControl?.endRefreshing()
        self.showAlertController(title: "", message: error)
    }
    
    func loadList(_ videos: [Video]) {
        loadImages(videos, self.reloadViewWith, self.loadError)
    }
    
    func reloadViewWith(_ videos: [Video]) {
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
        if let stringURL = self.videos[indexPath.row].videoURL {
            self.playVideo(stringURL)
        }
    }
    
    // MARK: - AVPlayerViewController
    
    func playVideo(_ url: String) {
        let videoURL = URL(string: url)
        let player = AVPlayer(url: videoURL!)
        let controller = AVPlayerViewController()
        controller.player = player
        self.present(controller, animated: true) {
            controller.player!.play()
        }
    }
    
}
