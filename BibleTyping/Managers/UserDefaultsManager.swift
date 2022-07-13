//
//  UserDefaultsManager.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/13.
//

import Foundation

protocol UserDefaultsManagerProtocol {
    
}

struct UserDefaultManager: UserDefaultsManagerProtocol {
    enum Key: String {
        case record
        
        var value: String {
            self.rawValue
        }
    }
    
    func getRecord() -> [RequestModel] {
        guard let data = UserDefaults.standard.data(forKey: Key.record.value) else { return [ ] }
        
        return (try? PropertyListDecoder().decode([RequestModel].self, from: data)) ?? [ ]
    }
    
    func setRecord(_ newValue: RequestModel) {
        var currentRecord: [RequestModel] = getRecord()
        currentRecord.insert(newValue, at: 0)
        
        UserDefaults.standard.setValue(
            try? PropertyListEncoder().encode(currentRecord),
            forKey: Key.record.value
        )
    }
}