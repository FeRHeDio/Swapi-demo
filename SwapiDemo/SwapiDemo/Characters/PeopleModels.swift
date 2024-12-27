//
//  PeopleModels.swift
//  SwapiDemo
//
//  Created by Fernando Putallaz on 24/12/2024.
//

import Foundation

struct PeopleResponse: Codable {
    let message: String
    let records: Int
    let pages: Int
    let results: [People]
    
    enum CodingKeys: String, CodingKey {
        case message
        case records = "total_records"
        case pages = "total_pages"
        case results
    }
}

struct People: Codable, Identifiable {
    var id: String { uid }
    let uid: String
    let name: String
    let url: String
}
