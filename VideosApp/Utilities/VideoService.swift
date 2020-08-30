//
//  VideoService.swift
//  VideosApp
//
//  Created by Prabhdeep Singh on 28/08/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation

class VideoService {
    
    static func loadDataFrom(name: String) -> [VideoModel] {
        if let fileUrl = Bundle.main.url(forResource: name,  withExtension: "json") {
            do {
                //let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl)
                do {
                    let videoModel = try JSONDecoder().decode([VideoModel].self, from: data)
                    //print(videoModel)
                    return videoModel
                } catch {
                    print("Error in decoding \(name) file")
                    return []
                }
               
            } catch {
                print("Error occured in loading data")
                return []
            }
        }
        return []
    }
    
   
    
}
