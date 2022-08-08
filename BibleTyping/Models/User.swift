//
//  User.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/13.
//

import Foundation

struct User: Codable {
    //var name: String
    let id: String
    
    static var shared = User(id: UUID().uuidString)
}
