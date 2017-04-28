//
//  FeaturedViewCell.swift
//  VidMe
//
//  Created by Vladimir Budniy on 4/25/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class FeaturedViewCell: UITableViewCell {
    
    @IBOutlet var backView: UIView?
    @IBOutlet var playerView: UIView?
    @IBOutlet var videoImageView: UIImageView?
    @IBOutlet var videoNameLabel: UILabel?
    @IBOutlet var likesCountLabel: UILabel?
    @IBOutlet var separateView: UIView?
    
    var spinner: SpinnerView?
    var urlString: String?
    
    // AVPlayerViewController
    var playerLayer: AVPlayerLayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.playerView?.isHidden = true
        self.videoImageView?.image = nil
        self.videoNameLabel?.text = ""
        self.likesCountLabel?.text = ""
    }
    
    // MARK: - Public
    
    func fillWithModel(_ model: Video?, _ tableView: UITableView) {
        if let model = model {
            self.imageView?.show(&self.spinner)
            self.settingCellSizeWith(model, tableView)
            self.urlString = model.videoURL

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
            
            self.backView?.frame.size = CGSize(width: width, height: height)
            self.frame.size = CGSize(width: width, height: height + 40)
        }
    }
    
    // MARK: Public
    
    func addPlayer() {
        let playerView = self.playerView
        playerView?.isHidden = false
        playerView?.show(&self.spinner)
        self.settinPlayerOn(playerView!)
    }
    
    func removePlayer() {
        DispatchQueue.main.async {
            self.playerLayer?.player?.pause()
            
            self.playerLayer?.player = nil
            self.playerLayer = nil
            
            UIView.transition(with: self.backView!, duration: 0.2, options: .transitionCurlDown, animations: {
                self.playerView?.isHidden = true
                self.videoImageView?.isHidden = false
            })
        }
    }
    
    // MARK: AVPlayer
    
    private func settinPlayerOn(_ view: UIView) {
        DispatchQueue.main.async {
            if let url = self.urlString {
                let url = URL(string: url)
                let layer = view.layer
                let player = AVPlayer(url: url!)
                let playerLayer = AVPlayerLayer(player: player)
                
                playerLayer.frame = (self.playerView?.frame)!
                playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                layer.addSublayer(playerLayer)
                
                self.playerLayer = playerLayer
                playerLayer.player?.play()
            }
            
            UIView.transition(with: self.backView!, duration: 0.4, options: .transitionCurlDown, animations: {
                view.remove(&self.spinner)
                self.videoImageView?.isHidden = true
            })
        }
    }
}
