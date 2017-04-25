//
//  ListViewCell.swift
//  VidMe
//
//  Created by Vladimir Budniy on 4/25/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit
import SDWebImage

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
            self.videoImageView?.sd_setShowActivityIndicatorView(true)
            self.videoImageView?.sd_setIndicatorStyle(.white)
            
            if let imageURL = model.imageURL {
                self.videoImageView?.sd_setImage(with: URL(string: imageURL))
            }
            
            self.videoNameLabel?.text = model.name
            self.likesCountLabel?.text = ((model.likesCount)?.description)! + " " + "likes"
            
            self.settingCellSizeWith(tableView)
        }
    }

    // MARK: - Private
    
    fileprivate func settingCellSizeWith(_ tableView: UITableView) {
        let height = (tableView.frame.width / 1.3333).rounded()
        self.videoImageView?.frame.size = CGSize(width: tableView.frame.width, height: height)
        self.frame.size = CGSize(width: tableView.frame.width, height: height + 40)
    }
    
}
