//
//  ResponseModel.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/05.
//

import Foundation

struct ResponseModel: Decodable {
    let items: Bible
}

struct Bible: Decodable {
    let book: String
    let chapter: Int
    let verse: Int
    var quote: String?
}

var AllBible: [Bible] = [
    Bible(book: "창세기", chapter: 50, verse: 1533),
    Bible(book: "출애굽기", chapter: 40, verse: 1213),
    Bible(book: "레위기", chapter: 27, verse: 859)
]
