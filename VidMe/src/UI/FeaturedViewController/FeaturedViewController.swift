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
    let identifier = String(describing: FeaturedViewCell.self)
    var videos = [Video]()
    var spinner: SpinnerView?

    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.delegate = self
        self.settingTableView()
        self.load()
    }
    
    // MARK: - Private
    
    func load() {
        let parameters = ["offset": 1, "limit": 10]
        loadVideos(URLPaths().featured, parameters, self.loadList, self.loadError)
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
        
        
        // add func fir refresh - remove all
        
        
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
    
    // MARK: - UITabBarControllerDelegate
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let index = tabBarController.selectedIndex
        if index == 2 {
            
//            let controller = FeedViewController()
            
        }
        
        print(index as Int)
    }
    
}
