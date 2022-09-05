//
//  BookmarkCollectionViewCell.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/08/30.
//

import UIKit
import SnapKit

final class BookmarkCollectionViewCell: UICollectionViewCell {
    static let identifier = "BookmarkCollectionViewCell" //Type property
    
    private lazy var bookNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        
        return label
    }()
    
    private lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        label.numberOfLines = 0
        
        return label
    }()
    
    func setup(from bookmark: Bookmark) {
        backgroundColor = .systemBackground
        layer.cornerRadius = 12.0
        
        bookNameLabel.text = NSLocalizedString(bookmark.bookname, comment: "bookmark.bookname") + " \(bookmark.chapter)\(NSLocalizedString("chapter", comment: "장")) \(bookmark.verse)\(NSLocalizedString("verse", comment: "절"))"
        
        quoteLabel.text = bookmark.quote
        
        [bookNameLabel, quoteLabel]
            .forEach { addSubview($0) }
        
        let insetSpacing: CGFloat = 16.0
        
        bookNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(insetSpacing)
            $0.trailing.equalToSuperview().inset(insetSpacing)
            $0.top.equalToSuperview().inset(insetSpacing)
            $0.width.equalTo(UIScreen.main.bounds.size.width - 64.0)
        }
        
        quoteLabel.snp.makeConstraints {
            $0.top.equalTo(bookNameLabel.snp.bottom).offset(insetSpacing)
            $0.leading.equalTo(bookNameLabel.snp.leading)
            $0.trailing.equalTo(bookNameLabel.snp.trailing)
            $0.bottom.equalToSuperview().inset(insetSpacing)
        }
    }
}
