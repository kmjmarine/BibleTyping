//
//  Language.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/09/17.
//

import Foundation

struct Language {
    let languageName: String
    let languageCode: String
}

extension Language {
    //Type Property 정의
    static let languageList: [Language] = [
        Language(languageName: "한국어", languageCode: "ko"),
        Language(languageName: "English", languageCode: "en"),
        Language(languageName: "中文", languageCode: "zh"),
        Language(languageName: "日本語", languageCode: "ja"),
        Language(languageName: "Deutsch", languageCode: "de"),
        Language(languageName: "Français", languageCode: "fr"),
    ]
}
