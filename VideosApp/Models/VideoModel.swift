//
//  VideoModel.swift
//  VideosApp
//
//  Created by Prabhdeep Singh on 28/08/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation


struct VideoModel: Decodable {
    var title: String
    var nodes: Array<Video>
}

struct Video: Decodable {
    var video: EncodeUrl
}

struct EncodeUrl: Decodable {
    var encodeUrl: String
}
