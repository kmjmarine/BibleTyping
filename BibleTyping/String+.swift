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
        
//        if position == "leading" {
//            addedstring = someString + self
//        } else {
//            addedstring = self + someString
//        }
        
        addedstring = position == "leading" ? someString + self : self + someString
        
        return addedstring
    }
}