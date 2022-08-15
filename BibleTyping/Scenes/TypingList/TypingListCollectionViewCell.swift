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
    
    private lazy var statusButton: UIButton = {
        let button = UIButton()

        button.setTitle("통독전", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 9.0
        
        button.addTarget(self, action: #selector(didTabConfirmButton), for: .touchUpInside)
        
        return button
    }()
    
    func setup(bible: Bible) {
        setupView()
        setupLayout()
        
        bookLabel.text = bible.bookName
        chapterLabel.text = "(\(String(bible.chapter)))"
    }
    
    func setupStatusButton(_ chapter: Int, _ verse: Int, _ doneWrite: Bool) {
        if doneWrite {
            statusButton.setTitle("통독완", for: .normal)
            statusButton.backgroundColor = .systemYellow
        } else if chapter != 0 && verse != 0 {
            var writeRecord: String
            writeRecord = "\(chapter)장 \(verse)절"
            statusButton.setTitle(writeRecord, for: .normal)
            statusButton.backgroundColor = .TitleBrown
        } else {
            statusButton.setTitle("통독전", for: .normal)
            statusButton.backgroundColor = .lightGray
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
        [bookLabel, chapterLabel, statusButton]
            .forEach { addSubview($0) }
        
        bookLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().inset(16.0)
        }
        
        chapterLabel.snp.makeConstraints {
            $0.leading.equalTo(bookLabel.snp.trailing)
            $0.bottom.equalTo(bookLabel.snp.bottom)
        }
        
        statusButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bookLabel.snp.bottom).offset(16.0)
            $0.width.equalToSuperview().inset(8.0)
        }
    }
    
    @objc func didTabConfirmButton() {
        ///TypingDetailViewController로 이동 구현 필요
    }
}
