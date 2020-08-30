//
//  VideoThumbnailCell.swift
//  VideosApp
//
//  Created by Prabhdeep Singh on 28/08/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import UIKit
import AVKit

class VideoThumbnailCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    let imageCache = NSCache<NSString, UIImage>()
    var imageUrl: NSString?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func getThumbnailImageFromVideoUrl(url: NSString, completion: @escaping ((_ image: UIImage?)->Void)) {
        
        guard let videoUrl = URL(string: url as String) else { return }
        completion(nil)
        
        if let thumbNailImage = imageCache.object(forKey: url) {
            print("cache ran \(url)")
            DispatchQueue.main.async {
                if self.imageUrl == url {
                    completion(thumbNailImage)
                }
            }
            return
        }
        
        DispatchQueue.global().async {
            let asset = AVAsset(url: videoUrl)
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            avAssetImageGenerator.appliesPreferredTrackTransform = true
            let thumnailTime = CMTimeMake(value: 2, timescale: 1)
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil)
                let thumbNailImage = UIImage(cgImage: cgThumbImage)
                
                DispatchQueue.main.async {
                    self.imageCache.setObject(thumbNailImage, forKey: url)
                    if self.imageUrl == url {
                        completion(thumbNailImage)
                    }
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
}
