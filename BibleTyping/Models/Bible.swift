//
//  Bible.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/10.
//

import Foundation

struct Bible: Decodable {
    let index: Int
    let bookCode: String
    let book: String
    let chapter: Int
    let verse: Int
    var quote: String?

    static let oldBible: [Bible] = [
        Bible(index: 1, bookCode:"ge", book: "창세기", chapter: 50, verse: 1533),
        Bible(index: 2, bookCode:"exo", book: "출애굽기", chapter: 40, verse: 1213),
        Bible(index: 3, bookCode:"lev", book: "레위기", chapter: 27, verse: 859),
        Bible(index: 4, bookCode:"num", book: "민수기", chapter: 36, verse: 1288),
        Bible(index: 5, bookCode:"deu", book: "신명기", chapter: 34, verse: 959),
        Bible(index: 6, bookCode:"josh", book: "여호수아", chapter: 24, verse: 658),
        Bible(index: 7, bookCode:"jdgs", book: "사사기", chapter: 21, verse: 618),
        Bible(index: 8, bookCode:"ruth", book: "룻기", chapter: 4, verse: 85),
        Bible(index: 9, bookCode:"1sm", book: "사무엘상", chapter: 31, verse: 810),
        Bible(index: 10, bookCode:"2sm", book: "사무엘하", chapter: 24, verse: 695),
        Bible(index: 11, bookCode:"1ki", book: "열왕기상", chapter: 22, verse: 816),
        Bible(index: 12, bookCode:"2ki", book: "열왕기하", chapter: 25, verse: 719),
        Bible(index: 13, bookCode:"1chr", book: "역대상", chapter: 29, verse: 942),
        Bible(index: 14, bookCode:"2chr", book: "역대하", chapter: 36, verse: 822),
        Bible(index: 15, bookCode:"ezra", book: "에스라", chapter: 10, verse: 280),
        Bible(index: 16, bookCode:"neh", book: "느헤미야", chapter: 13, verse: 406),
        Bible(index: 17, bookCode:"est", book: "에스더", chapter: 10, verse: 167),
        Bible(index: 18, bookCode:"job", book: "욥기", chapter: 42, verse: 1070),
        Bible(index: 19, bookCode:"psa", book: "시편", chapter: 150, verse: 2461),
        Bible(index: 20, bookCode:"prv", book: "잠언", chapter: 31, verse: 915),
        Bible(index: 21, bookCode:"eccl", book: "전도서", chapter: 12, verse: 222),
        Bible(index: 22, bookCode:"ssol", book: "아가", chapter: 8, verse: 117),
        Bible(index: 23, bookCode:"isa", book: "이사야", chapter: 66, verse: 1292),
        Bible(index: 24, bookCode:"jer", book: "예레미야", chapter: 52, verse: 1364),
        Bible(index: 25, bookCode:"lam", book: "예레미야애가", chapter: 5, verse: 154),
        Bible(index: 26, bookCode:"eze", book: "에스겔", chapter: 48, verse: 1273),
        Bible(index: 27, bookCode:"dan", book: "다니엘", chapter: 12, verse: 357),
        Bible(index: 28, bookCode:"hos", book: "호세아", chapter: 14, verse: 197),
        Bible(index: 29, bookCode:"joel", book: "요엘", chapter: 3, verse: 73),
        Bible(index: 30, bookCode:"amos", book: "아모스", chapter: 9, verse: 146),
        Bible(index: 31, bookCode:"obad", book: "오바댜", chapter: 1, verse: 21),
        Bible(index: 32, bookCode:"jonah", book: "요나", chapter: 4, verse: 48),
        Bible(index: 33, bookCode:"mic", book: "미가", chapter: 7, verse: 105),
        Bible(index: 34, bookCode:"nahum", book: "나훔", chapter: 3, verse: 47),
        Bible(index: 35, bookCode:"hab", book: "하박국", chapter: 3, verse: 56),
        Bible(index: 36, bookCode:"zep", book: "스바냐", chapter: 3, verse: 53),
        Bible(index: 37, bookCode:"hag", book: "학개", chapter: 2, verse: 38),
        Bible(index: 38, bookCode:"zep", book: "스가랴", chapter: 14, verse: 211),
        Bible(index: 39, bookCode:"mal", book: "말라기", chapter: 4, verse: 55)
    ]
    
    static let newBible: [Bible] = [
        Bible(index: 1, bookCode:"mat", book: "마태복음", chapter: 28, verse: 1071),
        Bible(index: 2, bookCode:"mark", book: "마가복음", chapter: 16, verse: 678),
        Bible(index: 3, bookCode:"luke", book: "누가복음", chapter: 24, verse: 1151),
        Bible(index: 4, bookCode:"john", book: "요한복음", chapter: 21, verse: 879),
        Bible(index: 5, bookCode:"acts", book: "사도행전", chapter: 28, verse: 1007),
        Bible(index: 6, bookCode:"rom", book: "로마서", chapter: 16, verse: 433),
        Bible(index: 7, bookCode:"1cor", book: "고린도전서", chapter: 16, verse: 437),
        Bible(index: 8, bookCode:"2cor", book: "고린도후서", chapter: 13, verse: 257),
        Bible(index: 9, bookCode:"gal", book: "갈라디아서", chapter: 6, verse: 149),
        Bible(index: 10, bookCode:"eph", book: "에베소서", chapter: 6, verse: 155),
        Bible(index: 11, bookCode:"phi", book: "빌립보서", chapter: 4, verse: 104),
        Bible(index: 12, bookCode:"col", book: "골로새서", chapter: 4, verse: 95),
        Bible(index: 13, bookCode:"1th", book: "데살로니가전서", chapter: 5, verse: 89),
        Bible(index: 14, bookCode:"2th", book: "데살로니가후서", chapter: 3, verse: 47),
        Bible(index: 15, bookCode:"1tim", book: "디모데전서", chapter: 6, verse: 113),
        Bible(index: 16, bookCode:"2tim", book: "디모데후서", chapter: 4, verse: 83),
        Bible(index: 17, bookCode:"titus", book: "디도서", chapter: 3, verse: 46),
        Bible(index: 18, bookCode:"phmn", book: "빌레몬서", chapter: 1, verse: 25),
        Bible(index: 19, bookCode:"heb", book: "히브리서", chapter: 13, verse: 303),
        Bible(index: 20, bookCode:"jas", book: "야고보서", chapter: 5, verse: 108),
        Bible(index: 21, bookCode:"1pet", book: "베드로전서", chapter: 5, verse: 105),
        Bible(index: 22, bookCode:"2pet", book: "베드로후서", chapter: 3, verse: 61),
        Bible(index: 23, bookCode:"1jn", book: "요한일서", chapter: 5, verse: 105),
        Bible(index: 24, bookCode:"2jn", book: "요한이서", chapter: 1, verse: 13),
        Bible(index: 25, bookCode:"3jn", book: "요한삼서", chapter: 1, verse: 14),
        Bible(index: 26, bookCode:"jude", book: "유다서", chapter: 1, verse: 25),
        Bible(index: 27, bookCode:"rev", book: "요한계시록", chapter: 22, verse: 404)
    ]
}
