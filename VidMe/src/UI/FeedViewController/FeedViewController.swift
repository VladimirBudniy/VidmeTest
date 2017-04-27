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
        
        self.addLogoutButton()
    }
    
    override func load(offset: Int = 0, primaryLoad: Bool = true) {
        self.videos.removeAll()
        self.tableView.reloadData()
        let token = userDefaults.value(forKey: const.token) as! String
        let headers = [const.AccessToken: token] as [String: String]
        let parameters = [const.token: token, const.limit: 50] as [String : Any]
        loadVideos(URLPaths().following, parameters, headers: headers, self.loadList, self.loadError)
    }
    
    // MARK: - Blocks methods
    
    func tokenCheck(_ isCheck: Bool) {
        if isCheck {
            self.load()
        } else {
            self.reloadTabBarController()
            UserDefaults.resetStandardUserDefaults()
            self.loadError(error: AlertControllerConst().userNotFound)
        }
    }
    
    // MARK: - Private

    private func addLogoutButton() {

    }
    
    private func reloadTabBarController() {
        let tabBarController = self.tabBarController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let featuredViewController = storyboard.instantiateViewController(withIdentifier: "FeaturedViewController")
        let newViewController = storyboard.instantiateViewController(withIdentifier: "NewViewController")
        let feedViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        let controllers = [featuredViewController, newViewController, feedViewController]
        
        tabBarController?.setViewControllers(controllers, animated: true)
        tabBarController?.selectedViewController = feedViewController
    }
    
    // MARK: - UIRefreshControl
    
    @objc override func refreshLoad() {
        self.tableView?.refreshControl?.endRefreshing()
        self.tableView?.show(&self.spinner)
        checkAuthenticationSession(self.tokenCheck)
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

    }

}
