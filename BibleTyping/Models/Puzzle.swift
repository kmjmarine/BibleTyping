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
        Puzzle(verse: "神は、 実に、 そのひとり子をお与えになったほどに世を愛された。 それは御子を信じる者が、 一人として滅びることなく、 永遠のいのちを持つためである。", verse_info: "(ヨハネの福音書 3:16)")
    ]
    
    static let puzzleZHList: [Puzzle] = [
        Puzzle(verse: "耶和华说、 我知道我向你们所怀的意念、 是赐平安的意念、 不是降灾祸的意念、 要叫你们末后有指望。", verse_info: "耶利米书 29:11"),
        Puzzle(verse: "凡劳苦担重担的人、 可以到我这里来、 我就使你们得安息。 我心里柔和谦卑、 你们当负我的轭、 学我的样式、 这样、 你们心里就必得享安息。 因为我的轭是容易的、 我的担子是轻省的。", verse_info: "马太福音 11:28-30"),
        Puzzle(verse: "因为我深信无论是死、 是生、 是天使、是掌权的、 是有能的、是现在的事、 是将来的事、 是高处的、 是低处的、 是别的受造之物、 都不能叫我们与　神的爱隔绝． 这爱是在我们的主基督耶稣里的。", verse_info: "罗马书 8:38-39"),
        Puzzle(verse: "〔大卫的诗、 交与伶长。 〕耶和华阿、 王必因你的能力欢喜． 因你的救恩、 他的快乐何其大。", verse_info: "诗篇 21:1"),
        Puzzle(verse: "〔耶稣说、 我就是道路、 真理、 生命． 若不借着我、 没有人能到父那里去。", verse_info: "约翰福音 14:6"),
        Puzzle(verse: "我岂没有吩咐你么． 你当刚强壮胆． 不要惧怕、 也不要惊惶、 因为你无论往那里去、 耶和华你的　神必与你同在。", verse_info: "约书亚记 1:9"),
        Puzzle(verse: "你们要休息、 要知道我是　神． 我必在外邦中被尊崇、 在遍地上也被尊崇。", verse_info: "诗篇 46:10"),
        Puzzle(verse: "各样美善的恩赐、 和各样全备的赏赐、 都是从上头来的． 从众光之父那里降下来的． 在他并没有改变、 也没有转动的影儿。", verse_info: "雅各书 1:17"),
        Puzzle(verse: "世人哪、耶和华已指示你何为善。他向你所要的是甚么呢。只要你行公义、好怜悯、存谦卑的心、与你的　神同行。", verse_info: "弥迦书 6:8")
    ]
    
    static let puzzleDEList: [Puzzle] = [
        Puzzle(verse: "Himmel und Erde werden vergehen; aber meine Worte werden nicht vergehen.", verse_info: "Matthäus 24:35"),
        Puzzle(verse: "Was zuvor geschrieben ist, das ist uns zur Lehre geschrieben.", verse_info: "Römer 15:4"),
        Puzzle(verse: "Ich habe euch lieb, spricht der Herr.", verse_info: "Maleachi 1:2"),
        Puzzle(verse: "uns wieder aufleben, um das Haus unseres Gottes aufzubauen und es aus seinen Trümmern wieder aufzurichten.", verse_info: "Esra 9:9"),
        Puzzle(verse: "Was ist das für ein Mann, dass ihm Wind und Meer gehorsam sind?", verse_info: "Matthäus 8:27"),
        Puzzle(verse: "Was zuvor geschrieben ist, das ist uns zur Lehre geschrieben.", verse_info: "Römer 15:4"),
        Puzzle(verse: "Du, Herr, bist meine Leuchte; der Herr macht meine Finsternis licht.", verse_info: "2.Samuel 22:29"),
        Puzzle(verse: "unserer Schwachheit auf. Denn wir wissen nicht, was wir beten sollen, wie sich's gebührt; sondern der Geist selbst vertritt uns mit unaussprechlichem Seufzen", verse_info: "Römer 8:26"),
        Puzzle(verse: "Meine Seele dürstet nach Gott, nach dem lebendigen Gott.", verse_info: "Psalm 42:3"),
        Puzzle(verse: "Jesus Christus, der sich selbst für unsre Sünden dahingegeben hat, dass er uns errette.", verse_info: "Galater 1:3-4"),
        Puzzle(verse: "Für wen mühe ich mich denn und gönne mir selber nichts Gutes?", verse_info: "Prediger 4:8"),
        Puzzle(verse: "Freundliche Reden sind Honigseim, trösten die Seele und erfrischen die Gebeine.", verse_info: "Sprüche 16:24"),
        Puzzle(verse: "In der Welt habt ihr Angst; aber seid getrost, ich habe die Welt überwunden.", verse_info: "Johannes 16:33"),
        Puzzle(verse: "Es sei aber fern von mir, mich zu rühmen als allein des Kreuzes unseres Herrn Jesus Christus.", verse_info: "Galater 6:14"),
    ]
    
    static let puzzleFRList: [Puzzle] = [
        Puzzle(verse: "Je t'instruirai et te montrerai la voie que tu dois suivre; Je te conseillerai, j'aurai le regard sur toi.", verse_info: "Psaumes 32:8"),
        Puzzle(verse: "Cantique de David. L'Eternel est mon berger: je ne manquerai de rien.", verse_info: "Psaumes 23:1"),
        Puzzle(verse: "Hymne de David. Garde-moi, ô Dieu! car je cherche en toi mon refuge.", verse_info: "Psaumes 16:1"),
        Puzzle(verse: "Nous savons, du reste, que toutes choses concourent au bien de ceux qui aiment Dieu, de ceux qui sont appelés selon son dessein.", verse_info: "Romains 8:28"),
        Puzzle(verse: "Jésus lui dit: Je suis le chemin, la vérité, et la vie. Nul ne vient au Père que par moi.", verse_info: "Jean 14:6"),
        Puzzle(verse: "Or sans la foi il est impossible de lui être agréable; car il faut que celui qui s'approche de Dieu croie que Dieu existe, et qu'il est le rémunérateur de ceux qui le cherchent.", verse_info: "Hébreux 11:6"),
        Puzzle(verse: "Louez l'Eternel! Mon âme, loue l'Eternel! Je louerai l'Eternel tant que je vivrai, Je célébrerai mon Dieu tant que j'existerai.", verse_info: "Psaumes 146:1-2"),
        Puzzle(verse: "Cherchez premièrement le royaume et la justice de Dieu; et toutes ces choses vous seront données par-dessus.", verse_info: "Matthieu 6:33"),
        Puzzle(verse: "Salomon engendra Roboam; Roboam engendra Abia; Abia engendra Asa; Asa engendra Josaphat; Josaphat engendra Joram; Joram engendra Ozias;", verse_info: "Matthieu 7:7-8"),
        Puzzle(verse: "Venez à moi, vous tous qui êtes fatigués et chargés, et je vous donnerai du repos.", verse_info: "Matthieu 11:28"),
        Puzzle(verse: "En vérité, en vérité, je vous le dis, celui qui écoute ma parole, et qui croit à celui qui m'a envoyé, a la vie éternelle et ne vient point en jugement, mais il est passé de la mort à la vie.", verse_info: "Jean 5:24"),
        Puzzle(verse: "Si vous demeurez en moi, et que mes paroles demeurent en vous, demandez ce que vous voudrez, et cela vous sera accordé.", verse_info: "Jean 15:7")
    ]
}

