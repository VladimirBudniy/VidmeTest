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
    @IBOutlet var videoNameLabel: UILabel?
    @IBOutlet var likesCountLabel: UILabel?

    @IBOutlet weak var separateView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }
    
    // MARK: - Public
    
    func fillWithModel(_ model: Video?, _ tableView: UITableView) {
        
        if let model = model {
            self.settingCellSizeWith(tableView)
            
            self.videoNameLabel?.text = model.name
            self.likesCountLabel?.text = ((model.likesCount)?.description)! + " " + "likes"
        }
    }

    // MARK: - Private
    
    fileprivate func settingCellSizeWith(_ tableView: UITableView) {
        let height = (tableView.frame.width / 1.3333).rounded()
        self.videoImageView?.frame.size.height = height
        self.frame.size = CGSize(width: tableView.frame.width, height: height + 40)
    }
    
}
