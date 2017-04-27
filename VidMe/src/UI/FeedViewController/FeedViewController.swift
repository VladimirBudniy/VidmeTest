//
//  FeedViewController.swift
//  VidMe
//
//  Created by Vladimir Budniy on 4/26/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit

class FeedViewController: FeaturedViewController {

    var logOutButton: UIButton?
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addLogoutButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.logOutButton?.alpha = 1
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    
        self.logOutButton?.alpha = 0
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
            self.logOut()
            self.loadError(error: AlertControllerConst().userNotFound)
        }
    }
    
    // MARK: - Private

    private func addLogoutButton() {
        let tabBarController = self.tabBarController
        let frame = tabBarController?.view.frame
        let tabBarHeight = tabBarController?.tabBar.frame.height
        let y = (frame?.height)! - (tabBarHeight! * 2)
        let logOutButton = UIButton(frame: CGRect(x: 0.0, y: y, width: (frame?.width)!, height: tabBarHeight!))

        let atributes = [
            NSFontAttributeName : UIFont(name: "Marker Felt", size: 18)!,
            NSForegroundColorAttributeName : UIColor.red] as [String : Any]
        
        let stringAtributes = NSAttributedString(string: "Logout", attributes: atributes)
        
        logOutButton.backgroundColor = UIColor.gray
        logOutButton.addTarget(self, action:  #selector(onLogoutButton), for: .touchUpInside)
        logOutButton.setAttributedTitle(stringAtributes, for: .normal)
        
        self.logOutButton = logOutButton
        tabBarController?.view.addSubview(logOutButton)
    }
    
    @objc private func onLogoutButton() {
        self.logOut()
    }

    private func logOut() {
        self.reloadTabBarController()
        self.clearUserDefaults()
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
    
    private func clearUserDefaults() {
        for key in userDefaults.dictionaryRepresentation().keys {
            userDefaults.removeObject(forKey: key)
        }
    }
    
    // MARK: - UIRefreshControl
    
    @objc override func refreshLoad() {
        self.tableView?.refreshControl?.endRefreshing()
        self.tabBarController?.view.show(&self.spinner)
        checkAuthenticationSession(self.tokenCheck)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

    }
}
