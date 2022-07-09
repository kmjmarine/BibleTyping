//
//  TypingTableViewCell.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/05.
//

import UIKit
import SnapKit

final class TypingTableViewCell: UITableViewCell {
    static let identifier = "TypingTableViewCell"
    
    private lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .systemBlue
        
        return label
    }()
    
    private lazy var writeTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    func setup(bible: Bible) {
        setupLayout()
        
        selectionStyle = .none
        
        quoteLabel.text = bible.quote//"아브라함과 다윗의 자손 예수 그리스도의 세계라"
    }
}

private extension TypingTableViewCell {
    func setupLayout() {
        [quoteLabel, writeTextField]
            .forEach { addSubview($0) }
        
        let superViewInset: CGFloat = 16.0
        let verticalSpacing: CGFloat = 32.0
        
        quoteLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(superViewInset)
            $0.trailing.equalToSuperview().inset(superViewInset)
            $0.top.equalToSuperview().inset(superViewInset)
        }
        
        writeTextField.snp.makeConstraints {
            $0.top.equalTo(quoteLabel.snp.bottom).offset(verticalSpacing)
            $0.leading.equalTo(quoteLabel.snp.leading)
            $0.trailing.equalTo(quoteLabel.snp.trailing)
        }
    }
}
