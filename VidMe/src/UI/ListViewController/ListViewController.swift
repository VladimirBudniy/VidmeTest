//
//  ListViewController.swift
//  VidMe
//
//  Created by Vladimir Budniy on 4/25/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    let identifier = String(describing: ListViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.settingTableVie()
    }
    
    // MARK: - Private
    
    fileprivate func settingTableVie() {
        self.tableView.contentInset.top = 20
        self.addRefreshControl()
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
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! ListViewCell
        cell.fillWithModel("", tableView)
        tableView.rowHeight = cell.frame.height

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
