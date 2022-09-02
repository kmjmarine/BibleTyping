//
//  UserDefaultsManager.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/13.
//

import Foundation

protocol UserDefaultsManagerProtocol {
    func getRecord() -> [Record]
    func setRecord(_ newValue: Record)
    func getBookmark() -> [Bookmark]
    func setBookmark(_ newValue: Bookmark)
    func delBookmark(_ newValue: Bookmark)
}

struct UserDefaultManager: UserDefaultsManagerProtocol {
    enum Key: String {
        case record
        case bookmarks
        
        //Computed Property (get-only)
        var value: String {
            self.rawValue
        }
    }
    
    //Method for Bible
    func getRecord() -> [Record] {
        guard let data = UserDefaults.standard.data(forKey: Key.record.value) else { return [] }
        
        return (try? PropertyListDecoder().decode([Record].self, from: data)) ?? [ ]
    }
    
    func setRecord(_ newValue: Record) {
        var currentRecord: [Record] = getRecord()
        currentRecord.insert(newValue, at: 0)
        
        UserDefaults.standard.setValue(
            try? PropertyListEncoder().encode(currentRecord),
            forKey: Key.record.value
        )
    }
    
    //Method for Bookmark
    func getBookmark() -> [Bookmark] {
        guard let data = UserDefaults.standard.data(forKey: Key.bookmarks.value) else { return [] }
        
        return (try? PropertyListDecoder().decode([Bookmark].self, from: data)) ?? []
    }
    
    func setBookmark(_ newValue: Bookmark) {
        var currentBookmarks: [Bookmark] = getBookmark()
        currentBookmarks.insert(newValue, at: 0)
        
        UserDefaults.standard.setValue(
            try? PropertyListEncoder().encode(currentBookmarks),
            forKey: Key.bookmarks.value
        )
    }
    
    func delBookmark(_ newValue: Bookmark) {
        var currentBookmakrs: [Bookmark] = getBookmark()
        
        if let index = currentBookmakrs.firstIndex(where: { $0.bookname == newValue.bookname && $0.chapter == newValue.chapter && $0.verse == newValue.verse
        }) {
            currentBookmakrs.remove(at: index)
            
            UserDefaults.standard.setValue(
                try? PropertyListEncoder().encode(currentBookmakrs),
                forKey: Key.bookmarks.value
            )
        }
    }
}
