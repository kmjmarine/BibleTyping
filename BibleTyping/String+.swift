//
//  String+.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/21.
//

import Foundation

extension String {
    mutating func addString(someString: String, position: String) -> String {
        var addedstring: String = ""
        addedstring = position == "leading" ? someString + self : self + someString
        
        return addedstring
    }
    
    var localized: String {
        var language = UserDefaults.standard.array(forKey: "language")?.first as? String
        if language == nil {
            let str = String(NSLocale.preferredLanguages[0])    // 언어코드-지역코드 (ex. ko-KR, en-US)
            language = String(str.dropLast(3))                  // ko-KR => ko, en-US => en
        }
        
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        return (bundle?.localizedString(forKey: self, value: nil, table: nil))!
    }
}
