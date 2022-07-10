//
//  Bible.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/10.
//

import Foundation

struct Bible: Decodable {
    let book: String
    let chapter: Int
    let verse: Int
    var quote: String?

    static let oldBible: [Bible] = [
        Bible(book: "창세기", chapter: 50, verse: 1533),
        Bible(book: "출애굽기", chapter: 40, verse: 1213),
        Bible(book: "레위기", chapter: 27, verse: 859),
        Bible(book: "민수기", chapter: 36, verse: 1288),
        Bible(book: "신명기", chapter: 34, verse: 959),
        Bible(book: "여호수아", chapter: 24, verse: 658),
        Bible(book: "사사기", chapter: 21, verse: 618),
        Bible(book: "룻기", chapter: 4, verse: 85),
        Bible(book: "사무엘상", chapter: 31, verse: 810),
        Bible(book: "사무엘하", chapter: 24, verse: 695),
        Bible(book: "열왕기상", chapter: 22, verse: 816),
        Bible(book: "열왕기하", chapter: 25, verse: 719),
        Bible(book: "역대상", chapter: 29, verse: 942),
        Bible(book: "역대하", chapter: 36, verse: 822),
        Bible(book: "에스라", chapter: 10, verse: 280),
        Bible(book: "느헤미야", chapter: 13, verse: 406),
        Bible(book: "에스더", chapter: 10, verse: 167),
        Bible(book: "욥기", chapter: 42, verse: 1070),
        Bible(book: "시편", chapter: 150, verse: 2461),
        Bible(book: "잠언", chapter: 31, verse: 915),
        Bible(book: "전도서", chapter: 12, verse: 222),
        Bible(book: "아가", chapter: 8, verse: 117),
        Bible(book: "이사야", chapter: 66, verse: 1292),
        Bible(book: "예레미야", chapter: 52, verse: 1364),
        Bible(book: "예레미야애가", chapter: 5, verse: 154),
        Bible(book: "에스겔", chapter: 48, verse: 1273),
        Bible(book: "다니엘", chapter: 12, verse: 357),
        Bible(book: "호세아", chapter: 14, verse: 197),
        Bible(book: "요엘", chapter: 3, verse: 73),
        Bible(book: "아모스", chapter: 9, verse: 146),
        Bible(book: "오바댜", chapter: 1, verse: 21),
        Bible(book: "요나", chapter: 4, verse: 48),
        Bible(book: "미가", chapter: 7, verse: 105),
        Bible(book: "나훔", chapter: 3, verse: 47),
        Bible(book: "하박국", chapter: 3, verse: 56),
        Bible(book: "스바냐", chapter: 3, verse: 53),
        Bible(book: "학개", chapter: 2, verse: 38),
        Bible(book: "스가랴", chapter: 14, verse: 211),
        Bible(book: "말라기", chapter: 4, verse: 55)
    ]
    
    static let newBible: [Bible] = [
        Bible(book: "마태복음", chapter: 28, verse: 1071),
        Bible(book: "마가복음", chapter: 16, verse: 678),
        Bible(book: "누가복음", chapter: 24, verse: 1151),
        Bible(book: "요한복음", chapter: 21, verse: 879),
        Bible(book: "사도행전", chapter: 28, verse: 1007),
        Bible(book: "로마서", chapter: 16, verse: 433),
        Bible(book: "고린도전서", chapter: 16, verse: 437),
        Bible(book: "고린도후서", chapter: 13, verse: 257),
        Bible(book: "갈라디아서", chapter: 6, verse: 149),
        Bible(book: "에베소서", chapter: 6, verse: 155),
        Bible(book: "빌립보서", chapter: 4, verse: 104),
        Bible(book: "골로새서", chapter: 4, verse: 95),
        Bible(book: "데살로니가전서", chapter: 5, verse: 89),
        Bible(book: "데살로니가후서", chapter: 3, verse: 47),
        Bible(book: "디모데전서", chapter: 6, verse: 113),
        Bible(book: "디모데후서", chapter: 4, verse: 83),
        Bible(book: "디도서", chapter: 3, verse: 46),
        Bible(book: "빌레몬서", chapter: 1, verse: 25),
        Bible(book: "히브리서", chapter: 13, verse: 303),
        Bible(book: "야고보서", chapter: 5, verse: 108),
        Bible(book: "베드로전서", chapter: 5, verse: 105),
        Bible(book: "베드로후서", chapter: 3, verse: 61),
        Bible(book: "요한일서", chapter: 5, verse: 105),
        Bible(book: "요한이서", chapter: 1, verse: 13),
        Bible(book: "요한삼서", chapter: 1, verse: 14),
        Bible(book: "유다서", chapter: 1, verse: 25),
        Bible(book: "요한계시록", chapter: 22, verse: 404)
    ]
}
