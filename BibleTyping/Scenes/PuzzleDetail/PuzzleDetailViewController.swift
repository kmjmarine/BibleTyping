//
//  PuzzleDetailViewController.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/08/02.
//

import UIKit

final class PuzzleDetailViewController: UIViewController {
    private var verse: String
    
    init(verse: String) {
        self.verse = verse
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
