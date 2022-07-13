//
//  SearchManager.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/05.
//

import Foundation
import Alamofire
import SwiftSoup

protocol SearchManagerProtocol {
    func request(
        from book: String,
        chapter: Int,
        verse: Int,
        completionHandler: @escaping(String) -> Void
    )
}

final class SearchManager: SearchManagerProtocol {
    func request(
        from book: String,
        chapter: Int,
        verse: Int,
        completionHandler: @escaping(String) -> Void
    ) {
        guard let url = URL(string: "https://ibibles.net/quote.php?\(book)/\(chapter):\(verse)-\(verse))") else { return }
        AF.request(url, method: .get)
            .responseString { response in
                guard let html = response.value else {
                    return
            }
                
            do {
                let doc: Document = try SwiftSoup.parse(html)
                let htmlText = try doc.body()!.text()
                completionHandler(htmlText)
                //print(htmlText)
            } catch {
                print("crawl error")
            }
        }
    }
}

