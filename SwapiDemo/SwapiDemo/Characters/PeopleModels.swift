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
}

struct People: Codable {
    let uid: String
    let name: String
    let url: String
}
