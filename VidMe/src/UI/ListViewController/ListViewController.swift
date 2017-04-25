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
    
        
        
        self.showSpinner()
        loadVideos(URLPaths().featured, videosBlock: self.reloadViewWith, errorBlock: self.loadError)
    
    
    
    
    
    
    
    }
    
    // MARK: - Private
    
    fileprivate func settingTableVie() {
        self.tableView.contentInset.top = 20
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
            self.removeSpinnerView()
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
    
    // MARK: - SpinnerView
    
    fileprivate func showSpinner(color: UIColor = UIColor.white) {
        var view = self.spinner
        if view == nil {
            view = SpinnerView.loadSpinner()
            view?.spinner?.color = color
            self.spinner = view
            view?.frame = self.tableView.frame
            view?.spinner?.startAnimating()
        }
        
        UIView.animate(withDuration: 1.0, animations: {
            view?.alpha = 0.6
            self.tableView.addSubview(view!)
        })
    }
    
    fileprivate func removeSpinnerView() {
        let view = self.spinner
        UIView.animate(withDuration: 1.0, animations: {
            view?.alpha = 0.1
        }, completion: { loaded in
            if loaded {
                view?.removeFromSuperview()
                self.spinner = nil;
            }
        })
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
