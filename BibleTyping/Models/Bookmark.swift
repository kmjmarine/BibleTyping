//
//  Bookmark.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/08/30.
//

import Foundation

struct Bookmark: Codable {
    let bookname: String
    let chapter: Int
    let verse: Int
    let quote: String
    let date: String?
    let language: String?
}
