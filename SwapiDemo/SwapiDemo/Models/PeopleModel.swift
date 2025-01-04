//
//  PeopleModel.swift
//  SwapiDemo
//
//  Created by Fernando Putallaz on 24/12/2024.
//

import Foundation
import SwiftUI

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
    var imageName: String {
        return UIImage(named: uid) != nil ? uid : "placeholder"
    }
}

extension People {
    static func mockData() -> [People] {
        return [
            People(uid: "1", name: "Luke Skywalker", url: "https://www.swapi.tech/api/people/1"),
            People(uid: "2", name: "C-3PO", url: "https://www.swapi.tech/api/people/2"),
            People(uid: "3", name: "R2-D2", url: "https://www.swapi.tech/api/people/3"),
            People(uid: "4", name: "Darth Vader", url: "https://www.swapi.tech/api/people/4"),
            People(uid: "5", name: "Leia Organa", url: "https://www.swapi.tech/api/people/5"),
            People(uid: "6", name: "Padme Amidala", url: "https://www.swapi.tech/api/people/6")
        ]
    }
}
