//
//  ListViewCell.swift
//  VidMe
//
//  Created by Vladimir Budniy on 4/25/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit

class ListViewCell: UITableViewCell {
    
    @IBOutlet var videoImageView: UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Public
    
    func fillWithModel(_ model: String?, _ tableView: UITableView) {
        self.settingCellSizeWith(tableView)
  
    }
    
    
    
    // MARK: - Private
    
    fileprivate func settingCellSizeWith(_ tableView: UITableView) {
        let height = (tableView.frame.width / 1.3333).rounded()
        self.videoImageView?.frame.size.height = height
        self.frame.size = CGSize(width: tableView.frame.width, height: height + 40)
    }
    
    
}
