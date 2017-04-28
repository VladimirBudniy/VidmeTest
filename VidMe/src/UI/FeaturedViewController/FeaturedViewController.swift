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
    
    var playCell: FeaturedViewCell?
    
    // pagination
    var offset = 0
    var totalVideListCount = 1000 // abstract limit, we can added limit from JSON for videos.

    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.delegate = self
        self.settingTableView()
        self.load()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.playCell?.removePlayer()
    }
    
    // MARK: - Public
    
    func prepareForLoad(_ offset: Int) {
        let parameters = [const.offset: offset, const.limit: self.videoLimit]
        loadVideos(URLPaths().featured, parameters, self.loadList, self.loadError)
    }
    
    func load(offset: Int = 0, primaryLoad: Bool = true) {
        if primaryLoad {
            self.videos.removeAll()
            self.tableView.reloadData()
            self.prepareForLoad(offset)
        } else {
            self.prepareForLoad(offset)
        }
    }
    
    func settingTableView() {
        let tableView = self.tableView
        tableView?.contentInset.top = 20
        tableView?.contentInset.bottom = 49
        self.tabBarController?.view.show(&self.spinner)
        self.addRefreshControl()
    }
    
    func showAlertController(title: String? = nil, message: String) {
        self.present(self.alertViewController(title: title, message: message), animated: true, completion: nil)
    }
    
    // MARK: - Blocks methods
    
    func loadError(error: String) {
        self.tableView?.refreshControl?.endRefreshing()
        self.showAlertController(title: "", message: error)
        self.tabBarController?.view.remove(&self.spinner)
    }
    
    func loadList(_ videos: [Video]) {
        loadImages(videos, self.reloadViewWith, self.loadError)
    }
    
    func reloadViewWith(_ videos: [Video]) {
        if videos.count != 0 {
            let videos = videos.sorted(by: {$0.datePublished! > $1.datePublished!})
            self.videos.append(contentsOf: videos)
            self.tableView?.reloadData()
            self.tabBarController?.view.remove(&self.spinner)
            self.tableView.remove(&self.spinner)
        }
    }
    
    // MARK: - UIRefreshControl
    
    func addRefreshControl() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshLoad), for: .valueChanged)
        self.tableView.refreshControl = refresh
    }
    
    @objc func refreshLoad() {
        self.playCell?.removePlayer()
        self.tableView?.refreshControl?.endRefreshing()
        self.tabBarController?.view.show(&self.spinner)
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

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! FeaturedViewCell
        cell.fillWithModel(self.videos[indexPath.row], tableView)
        tableView.rowHeight = cell.frame.height

        return cell
    }

    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FeaturedViewCell
        cell.removePlayer()
        
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
    
    // MARK: - UIScrollViewDelegate
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let bounds = scrollView.bounds
        let size = bounds.size
        let y = offset.y + ((size.height - scrollView.contentInset.top) / 2)
        
        if y <= 0 {
            print("Hello")
        } else {
            let point = CGPoint(x: 0.0, y: y)
            if let indexPath = self.tableView.indexPathForRow(at: point) {
                if let centerCell = self.tableView.cellForRow(at: indexPath) {
                    let cell = centerCell as! FeaturedViewCell
                    
                    if self.playCell != cell {
                        self.playCell?.removePlayer()
                        cell.addPlayer()
                        self.playCell = cell
                    } else {
                        
                    }
                }
            }
        }
    }
    
}
