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
    
    var spinner: SpinnerView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }
    
    // MARK: - Public
    
    func fillWithModel(_ model: Video?, _ tableView: UITableView) {
        if let model = model {
            self.imageView?.show(&self.spinner)
            self.settingCellSizeWith(model, tableView)

            if let image = model.image {
                self.videoImageView?.image = image
                self.imageView?.remove(&self.spinner)
            }
            
            self.videoNameLabel?.text = model.name
            self.likesCountLabel?.text = ((model.likesCount)?.description)! + " " + "likes"
        }
    }
    
    // MARK: - Private
    
    fileprivate func settingCellSizeWith(_ model: Video?, _ tableView: UITableView) {
        if let image = model?.image {
            let value = (tableView.frame.size.width / image.size.width)
            let height = (image.size.height * value).rounded()
            let width = tableView.frame.width
            
            self.videoImageView?.frame.size = CGSize(width: width, height: height)
            self.frame.size = CGSize(width: width, height: height + 40)
        }
    }
    
}
