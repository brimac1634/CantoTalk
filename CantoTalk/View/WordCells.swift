//
//  WordCells.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 31/7/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit
import RealmSwift

class WordCells: BaseCell {
    
    var cellStackViewTrailingConstraint: NSLayoutConstraint!
    
    var selectedEntry: Entries? {
        didSet {
            if let entry = selectedEntry {
                setupCellContent(entry: entry)
                
            }
        }
    }
    
    func setupCellContent(entry: Entries) {
        let cantoWordText = NSMutableAttributedString(string: entry.cantoWord, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25), NSAttributedString.Key.foregroundColor: UIColor.cantoDarkBlue(a: 1)])
        if entry.classifier != "" {
            cantoWordText.append(NSAttributedString(string: " (cl:\(entry.classifier))", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.cantoDarkBlue(a: 1)]))
        }
        
        
        cantoWordLabel.attributedText = cantoWordText
        jyutpingLabel.text = entry.jyutping
        
        let englishWordText = NSMutableAttributedString(string: "En: ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.cantoDarkBlue(a: 1)])
        englishWordText.append(NSAttributedString(string: entry.englishWord, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.cantoDarkBlue(a: 1)]))
        
        englishWordLabel.attributedText = englishWordText
        
        let mandarinWordText = NSMutableAttributedString(string: "普: ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.cantoDarkBlue(a: 1)])
        mandarinWordText.append(NSAttributedString(string: entry.mandarinWord, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.cantoDarkBlue(a: 1)]))
        
        mandarinWordLabel.attributedText = mandarinWordText
    }
    
    
    let cantoWordLabel: UITextView = {
        let label = UITextView()
        label.isEditable = false
        label.isScrollEnabled = false
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    let englishWordLabel: UITextView = {
        let label = UITextView()
        label.isEditable = false
        label.isScrollEnabled = false
        label.isUserInteractionEnabled = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        return label
    }()
    
    let mandarinWordLabel: UITextView = {
        let label = UITextView()
        label.isEditable = false
        label.isScrollEnabled = false
        label.isUserInteractionEnabled = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        return label
    }()
    
    let jyutpingLabel: UITextView = {
        let label = UITextView()
        label.isEditable = false
        label.isScrollEnabled = false
        label.isUserInteractionEnabled = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.cantoDarkBlue(a: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func setupViews() {
        
        let topStackView = UIStackView(arrangedSubviews: [cantoWordLabel, englishWordLabel])
        let bottomStackView = UIStackView(arrangedSubviews: [jyutpingLabel, mandarinWordLabel])
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.distribution = .fillEqually
        bottomStackView.distribution = .fillEqually
        
        let cellStackView = UIStackView(arrangedSubviews: [topStackView, bottomStackView])
        cellStackView.distribution = .fillEqually
        cellStackView.spacing = 0
        cellStackView.translatesAutoresizingMaskIntoConstraints = false
        cellStackView.axis = .vertical
        
        addSubview(cellStackView)
        addSubview(separatorView)
        
        cellStackViewTrailingConstraint = cellStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        
        NSLayoutConstraint.activate([
            
            cellStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            cellStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            cellStackViewTrailingConstraint,
            cellStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
            ])
   
    }
   
}

















