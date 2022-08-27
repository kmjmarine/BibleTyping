//
//  TypingListCollectionViewCell.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/09.
//

import Foundation
import UIKit
import SnapKit

final class TypingListCollectionViewCell: UICollectionViewCell {
    static let identifier = "TypingListCollectionViewCell"
    
    private lazy var bookLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        
        return label
    }()
    
    private lazy var chapterLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12.0, weight: .semibold)
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.spacing = 1.0
        stackView.alignment = .center
        
        [bookLabel, chapterLabel]
            .forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .semibold)
        label.text = "통독전"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .lightGray
        label.clipsToBounds = true
        label.layer.cornerRadius = 10.0
        
        return label
    }()
    
    func setup(bible: Bible) {
        setupView()
        setupLayout()
        
        bookLabel.text = bible.bookName
        chapterLabel.text = "(\(String(bible.chapter)))"
    }
    
    func setupStatusLabel(_ chapter: Int, _ verse: Int, _ doneWrite: Bool) {
        if doneWrite {
            statusLabel.text = "통독완"
            statusLabel.backgroundColor = .systemYellow
        } else if chapter != 0 && verse != 0 {
            var writeRecord: String
            writeRecord = "\(chapter)장 \(verse)절"
            statusLabel.text = writeRecord
            statusLabel.backgroundColor = .TitleBrown
        } else {
            statusLabel.text = "통독전"
            statusLabel.backgroundColor = .lightGray
        }
    }
}

extension TypingListCollectionViewCell {
    func setupView() {
        layer.cornerRadius = 12.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 8.0
        
        backgroundColor = .systemBackground
    }
    
    func setupLayout() {
        [stackView, statusLabel]
            .forEach { addSubview($0) }
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16.0)
            $0.centerX.equalToSuperview()
        }
        
        statusLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bookLabel.snp.bottom).offset(16.0)
            $0.width.equalToSuperview().inset(8.0)
            $0.height.equalTo(28.0)
        }
    }
}
