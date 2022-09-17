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
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var chapterVerseLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12.0, weight: .semibold)
        label.textColor = .systemGray
        
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .semibold)
        label.text = "noReading".localized
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .lightGray
        label.clipsToBounds = true
        label.layer.cornerRadius = 10.0
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 8.0
        stackView.alignment = .center
        
        [bookLabel, chapterVerseLabel, statusLabel]
            .forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    func setup(bible: Bible) {
        setupView()
        setupLayout()
        
        var chapterVerse: String {
            return "(" + String(bible.chapter) + "chapter".localized + " " + String(bible.verse) + "verse".localized + ")"
        }
        
        bookLabel.text = bible.bookName.localized
        chapterVerseLabel.text = chapterVerse
    }
    
    func setupStatusLabel(_ chapter: Int, _ verse: Int, _ doneWrite: Bool) {
        if doneWrite {
            statusLabel.text = "doneReading".localized
            statusLabel.backgroundColor = .systemYellow
        } else if chapter != 0 && verse != 0 {
            var writeRecord: String
            writeRecord = "\(chapter)\("chapter".localized) \(verse)\("verse".localized)"
            statusLabel.text = writeRecord
            statusLabel.backgroundColor = .TitleBrown
        } else {
            statusLabel.text = "noReading".localized
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
        [stackView]
            .forEach { addSubview($0) }
        
        bookLabel.snp.makeConstraints {
            $0.width.equalTo(90.0)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8.0)
            $0.centerX.equalToSuperview()
        }
        
        statusLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(28.0)
        }
    }
}
