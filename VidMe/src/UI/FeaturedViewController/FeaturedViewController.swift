//
//  FeaturedViewController.swift
//  VidMe
//
//  Created by Vladimir Budniy on 4/25/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class FeaturedViewController: UITableViewController, AlertViewController, UITabBarControllerDelegate {
    
    let alertViewController = UIAlertController()
    let const = AuthConst()
    let videoLimit = 10
    let identifier = String(describing: FeaturedViewCell.self)
    var videos = [Video]()
    var spinner: SpinnerView?
    
    // paganation 
    var offset = 0
    var totalVideListCount = 5374
    

    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.delegate = self
        self.settingTableView()
        self.load()
    }
    
    // MARK: - Private
    
    func load(offset: Int = 0, primaryLoad: Bool = true) {
        if primaryLoad {
            
            self.videos.removeAll()
            self.tableView.reloadData()
            
            let parameters = [const.offset: offset, const.limit: self.videoLimit]
            loadVideos(URLPaths().featured, parameters, self.loadList, self.loadError)
        } else {
            let parameters = [const.offset: offset, const.limit: self.videoLimit]
            loadVideos(URLPaths().featured, parameters, self.loadList, self.loadError)
        }
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
            let videos = videos.sorted(by: {$0.datePublished! > $1.datePublished!})
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
        self.load()
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

    // MARK: - TableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! FeaturedViewCell
        cell.fillWithModel(self.videos[indexPath.row], tableView)
        tableView.rowHeight = cell.frame.height

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let stringURL = self.videos[indexPath.row].videoURL {
            self.playVideo(stringURL)
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var offset = self.offset;
        let section = tableView.numberOfSections - 1
        let lastRow = tableView.numberOfRows(inSection: section) - 1

        if indexPath.row == lastRow, lastRow < totalVideListCount {
            offset += self.videoLimit + 1
            
            self.load(offset: offset, primaryLoad: false)
            self.offset = offset
        }
    }
    
}
