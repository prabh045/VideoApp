//
//  PlayerViewController.swift
//  VideosApp
//
//  Created by Prabhdeep Singh on 29/08/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    //MARK: Properties
    var selectedCategoryIndex: Int = 0
    var selectedVideoIndex: Int = 0
    var videoData: Array<VideoModel> = []
    var player: AVPlayer?
    
    //MARK: Outlets
    @IBOutlet weak var backButton: UIButton!
    
    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.tintColor = UIColor.white
        setupPlayer(videoUrl: videoData[selectedCategoryIndex].nodes[selectedVideoIndex].video.encodeUrl)
    }
    
    //MARK: AVPLayer
    func setupPlayer(videoUrl: String) {
        print("Video url is \(videoUrl)")
        if let url = URL(string: videoUrl) {
            self.player = AVPlayer(url: url)
            let layer = AVPlayerLayer(player: player)
            layer.frame = self.view.bounds
            layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            view.layer.addSublayer(layer)
            view.bringSubviewToFront(backButton)
            player?.play()
        }
    }
    
    //MARK: Actions
    @IBAction func backAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
