//
//  BibleJson.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/08/15.
//

import Foundation

struct BibleJson: Codable {
    let Bibles: [Bibles]
}

struct Bibles: Codable {
    let bookName: String
    let chapter: Int
    let verse: Int
}
