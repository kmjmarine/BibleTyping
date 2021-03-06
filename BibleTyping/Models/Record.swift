//
//  RequestModel.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/05.
//

import Foundation

struct Record: Codable {
    let user: User
    let bookkind: String
    let bookname: String
    let chapter: Int
    let verse: Int
}
