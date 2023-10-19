//
//  ProductCompaniesModel.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import Foundation

struct ProductionCompaniesModel: Equatable, Identifiable {
    let id: Int
    let logoPath: String
    let name: String
    let originalCountry: String
}
