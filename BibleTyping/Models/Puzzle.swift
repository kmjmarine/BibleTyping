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
        Puzzle(verse: "복 있는 사람은 악인들의 꾀를 따르지 아니하며 죄인들의 길에 서지 아니하며 오만한 자들의 자리에 앉지 아니하고", verse_info: "(시 1:1)"),
        Puzzle(verse: "우리가 알거니와 하나님을 사랑하는 자 곧 그의 뜻대로 부르심을 입은 자들에게는 모든 것이 합력하여 선을 이루느니라", verse_info: "(로 8:28)"),
        Puzzle(verse: "나의 하나님이 그리스도 예수 안에서 영광 가운데 그 풍성한 대로 너희 모든 쓸 것을 채우시리라", verse_info: "(빌 4:19)"),
        Puzzle(verse: "여호와는 나의 빛이요 나의 구원이시니 내가 누구를 두려워하리요 여호와는 내 생명의 능력이시니 내가 누구를 무서워하리요", verse_info: "(시 27:1)"),
        Puzzle(verse: "예수께서 이르시되 내가 곧 길이요 진리요 생명이니 나로 말미암지 않고는 아버지께로 올 자가 없느니라", verse_info: "(요 14:6)")
    ]
}
