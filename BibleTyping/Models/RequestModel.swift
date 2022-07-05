//
//  RequestModel.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/05.
//

import Foundation

struct RequestModel: Codable {
    let book: String
    let chapter: String
    let verse: String
}
