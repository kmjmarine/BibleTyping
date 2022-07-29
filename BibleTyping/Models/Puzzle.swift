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
        Puzzle(verse: "여호와는 나의 목자시니 내게 부족함이 없으리로다", verse_info: "(시 23:1)"),
        Puzzle(verse: "하나님이여 나를 지켜 주소서 내가 주께 피하나이다", verse_info: "(시 16:1)"),
        Puzzle(verse: "나의 힘이신 여호와여 내가 주를 사랑하나이다", verse_info: "(시 18:1)"),
        Puzzle(verse: "너희 염려를 다 주께 맡기라 이는 그가 너희를 돌보심이라", verse_info: "(벧전 5:7)"),
        Puzzle(verse: "내게 능력 주시는 자 안에서 내가 모든 것을 할 수 있느니라", verse_info: "(빌 4:13)"),
        Puzzle(verse: "너희가 내 안에 거하고 내 말이 너희 안에 거하면 무엇이든지  원하는 대로 구하라 그리하면 이루리라", verse_info: "(요 15:7)")
    ]
}
