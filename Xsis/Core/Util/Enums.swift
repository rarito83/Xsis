//
//  Enums.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import Foundation

public enum Tabs {
    case home
    case search
    case favorite
}

enum ProgressState {
    case idle
    case loading
    case error(Error)
    case loaded
}
