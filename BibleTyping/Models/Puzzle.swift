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
    static let puzzleKOList: [Puzzle] = [
        Puzzle(verse: "내 형제들아 너희가 여러 가지 시험을 당하거든 온전히 기쁘게 여기라", verse_info: "(약 1:2)"),
        Puzzle(verse: "내가 네 갈 길을 가르쳐 보이고 너를 주목하여 훈계하리로다", verse_info: "(시 32:8)"),
        Puzzle(verse: "여호와는 나의 목자시니 내게 부족함이 없으리로다 그가 나를 푸른 초장에 누이시며 쉴 만한 물가으로 인도하시는도다", verse_info: "(시 23:1)"),
        Puzzle(verse: "하나님이여 나를 지켜 주소서 내가 주께 피하나이다", verse_info: "(시 16:1)"),
        Puzzle(verse: "나의 힘이신 여호와여 내가 주를 사랑하나이다", verse_info: "(시 18:1)"),
        Puzzle(verse: "너희 염려를 다 주께 맡기라 이는 그가 너희를 돌보심이라", verse_info: "(벧전 5:7)"),
        Puzzle(verse: "내게 능력 주시는 자 안에서 내가 모든 것을 할 수 있느니라", verse_info: "(빌 4:13)"),
        Puzzle(verse: "복 있는 사람은 악인들의 꾀를 따르지 아니하며 죄인들의 길에 서지 아니하며 오만한 자들의 자리에 앉지 아니하고", verse_info: "(시 1:1)"),
        Puzzle(verse: "우리가 알거니와 하나님을 사랑하는 자 곧 그의 뜻대로 부르심을 입은 자들에게는 모든 것이 합력하여 선을 이루느니라", verse_info: "(로 8:28)"),
        Puzzle(verse: "나의 하나님이 그리스도 예수 안에서 영광 가운데 그 풍성한 대로 너희 모든 쓸 것을 채우시리라", verse_info: "(빌 4:19)"),
        Puzzle(verse: "여호와는 나의 빛이요 나의 구원이시니 내가 누구를 두려워하리요 여호와는 내 생명의 능력이시니 내가 누구를 무서워하리요", verse_info: "(시 27:1)"),
        Puzzle(verse: "예수께서 이르시되 내가 곧 길이요 진리요 생명이니 나로 말미암지 않고는 아버지께로 올 자가 없느니라", verse_info: "(요 14:6)"),
        Puzzle(verse: "믿음이 없이는 하나님을 기쁘시게 하지 못하나니 하나님께 나아가는 자는 반드시 그가 계신 것과 또한 그가 자기를 찾는 자들에게 상 주시는 이심을 믿어야 할지니라", verse_info: "(히 11:6)"),
        Puzzle(verse: "너는 하나님과 화목하고 평안하라 그리하면 복이 네게 임하리라", verse_info: "(욥 22:21)"),
        Puzzle(verse: "내 영혼아 네가 어찌하여 낙망하며 어찌하여 네 속에서 불안하여 하는고 너는 하나님을 바라라 그 얼굴의 도우심을 인하여 내가 오히려 찬송하리로다", verse_info: "(시 42:5)"),
        Puzzle(verse: "할렐루야 내 영혼아 여호와를 찬양하라 나의 생전에 여호와를 찬양하며 나의 평생에 내 하나님을 찬송하리로다", verse_info: "(시 146:1-2)"),
        Puzzle(verse: "두려워 말라 내가 너와 함께 함이니라. 놀라지 말라 나는 네 하나님이 됨이니라. 내가 너를 굳세게 하리라. 참으로 너를 도와 주리라. 참으로 나의 의로운 오른손으로 너를 붙들리라.", verse_info: "(사 41:10)"),
        Puzzle(verse: "너희는 먼저 그의 나라와 그의 의를 구하라. 그리하면 이 모든 것을 너희에게 더하시리라.", verse_info: "(마 6:33)"),
        Puzzle(verse: "구하라 그러면 너희에게 주실 것이요 찾으라 그러면 찾을 것이요 문을 두드리라 그러면 너희에게 열릴 것이니 구하는 이마다 얻을 것이요 찾는 이가 찾을 것이요 두드리는 이에게 열릴 것이니라.", verse_info: "(마 7:7-8)"),
        Puzzle(verse: "수고하고 무거운 짐진 자들아 다 내게로 오라 내가 너희를 쉬게 하리라.", verse_info: "(마 11:28)"),
        Puzzle(verse: "내가 진실로 진실로 너희에게 이르노니, 내 말을 듣고 또 나 보내신 이를 믿는 자는, 영생을 얻었고 심판에 이르지 아니하나니 사망에서 생명으로 옮겼느니라.", verse_info: "(요 5:24)"),
        Puzzle(verse: "새 계명을 너희에게 주노니 서로 사랑하라. 내가 너희를 사랑한 것같이 너희도 서로 사랑하라. 너희가 서로 사랑하면 이로써 모든 사람이 너희가 내 제자인 줄 알리라.", verse_info: "(요 13:34-35)"),
        Puzzle(verse: "너희가 내 안에 거하고 내 말이 너희 안에 거하면 무엇이든지 원하는 대로 구하라. 그리하면 이루리라.", verse_info: "(요 15:7)")
    ]
    
    static let puzzleENList: [Puzzle] = [
        Puzzle(verse: "I am able to do all things through him who gives me strength", verse_info: "(Philippians 4:13)"),
        Puzzle(verse: "But he knows what I am doing, and when he tests me, I will be pure as gold.", verse_info: "(Job 23:10)"),
        Puzzle(verse: "For God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life", verse_info: "(John 3:16)"),
        Puzzle(verse: "We make our own plans, but the LORD decides where we will go.", verse_info: "(Proverbs 16:9)"),
        Puzzle(verse: "For now there are faith, hope, and love. But of these three, the greatest is love", verse_info: "(1 Corinthians 13:13)"),
        Puzzle(verse: "Respect and obey the LORD! This is the beginning of wisdom. To have understanding, you must know the Holy God", verse_info: "(Proverbs 9:10)"),
        Puzzle(verse: "Yet to all who did received him, to those who believed his name, he gave the right to become children of God", verse_info: "(John 1:12)"),
        Puzzle(verse: "Don't worry about anything, but pray about everything. With thankful hearts offer up your prayers and requests to God", verse_info: "(Philippians 4:6)"),
        Puzzle(verse: "For God so loved the world that he gave his one and only Son, that whoever believes in him shall not perish but have eternal life.", verse_info: "(John 3:16)"),
        Puzzle(verse: "Be joyful always, pray continually, give thanks in all circumstances, for this is God's will for you in Christ Jesus.", verse_info: "(1 Thessalonians 5:16~18)"),
        Puzzle(verse: "For we brought nothing åç the world, and we can take nothing out of it.", verse_info: "(1 Timothy 6:7)"),
        Puzzle(verse: "And now these three remain: faith, hope and love . But the greatest of these is love.", verse_info: "(1 Corinthians 13:13)"),
        Puzzle(verse: "In his heart a man plans his course, but the LORD determines his steps.", verse_info: "(Proverbs 16:9)")
    ]
    
    static let puzzleJAList: [Puzzle] = [
        Puzzle(verse: "というのは、 神がお造りになったものはすべて良いものであり、 感謝して受けるならば、 何一つ捨てるものはないからです。", verse_info: "(テモテへの手紙 4:4)"),
        Puzzle(verse: "ウツの地にヨブという人がいた。 無垢な正しい人で、 神を畏れ、 悪を避けて生きていた。", verse_info: "(ヨブ記 1:1)"),
        Puzzle(verse: "すべての王よ、 今や目覚めよ。 地を治めるものよ、 諭しを受けよ。", verse_info: "(詩編 2:10)"),
        Puzzle(verse: "主よ、 諸国の民を裁いてください。 主よ、 裁きを行って宣言してください。 お前は正しい、 とがめるところはないと。", verse_info: "(詩編 7:8)"),
        Puzzle(verse: "主はギデオンに言われた。 「手から水をすすった三百人をもって、 わたしはあなたたちを救い、 ミディアン人をあなたの手に渡そう。 他の民はそれぞれ自分の所に返しなさい。", verse_info: "(士師記 7:7)"),
        Puzzle(verse: "神は、 実に、 そのひとり子をお与えになったほどに世を愛された。 それは御子を信じる者が、 一人として滅びることなく、 永遠のいのちを持つためである。", verse_info: "(ヨハネの福音書 3:16)"),
    ]
}

