//
//  Puzzle.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/26.
//

import Foundation

struct Puzzle {
    let verse: String
    let verse_info: String
}

extension Puzzle {
    static let puzzleList: [Puzzle] = [
        Puzzle(verse: "내 형제들아 너희가 여러 가지 시험을 당하거든 온전히 기쁘게 여기라", verse_info: "(약 1:2)"),
        Puzzle(verse: "내가 네 갈 길을 가르쳐 보이고 너를 주목하여 훈계하리로다", verse_info: "(시 32:8)"),
        Puzzle(verse: "여호와는 나의 목자시니 내게 부족함이 없으리로다", verse_info: "(시 23:1)")
    ]
}
