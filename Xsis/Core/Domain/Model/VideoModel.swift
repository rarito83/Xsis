//
//  VideoModel.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import Foundation

struct VideoModel: Equatable, Identifiable {
    let name, key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let publishedAt, id: String
}
