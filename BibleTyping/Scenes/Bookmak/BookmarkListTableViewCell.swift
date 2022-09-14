//
//  BookmarkTableViewCell.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/09/13.
//

import UIKit
import SnapKit

final class BookmarkListTableViewCell: UITableViewCell {
    static let identifier = "BookmarkTableViewCell"
    
    private lazy var bookNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .systemGray
        
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10.0
        
        [bookNameLabel, dateLabel]
            .forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    private lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        label.numberOfLines = 0
        
        return label
    }()
    
    func setup(from bookmark: Bookmark) {
        selectionStyle = .none //tab시 배경색 안바
        
        //computed property
        var bookLabelText: String {
            return bookmark.bookname.localized + " \(bookmark.chapter)\("chapter".localized) \(bookmark.verse)\("verse".localized)"
        }
        
        bookNameLabel.text = bookLabelText
        dateLabel.text = bookmark.date
        quoteLabel.text = bookmark.quote
        
        [labelStackView, quoteLabel]
            .forEach { addSubview($0) }
        
        let insetSpacing: CGFloat = 16.0
        
        labelStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(insetSpacing)
            $0.leading.equalToSuperview().inset(insetSpacing)
            $0.trailing.equalToSuperview().inset(insetSpacing)
        }
        
        quoteLabel.snp.makeConstraints {
            $0.top.equalTo(labelStackView.snp.bottom).offset(insetSpacing)
            $0.leading.equalTo(labelStackView.snp.leading)
            $0.trailing.equalTo(labelStackView.snp.trailing)
            $0.bottom.equalToSuperview().inset(insetSpacing)
        }
    }
}
