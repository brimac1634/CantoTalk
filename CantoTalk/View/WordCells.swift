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
    
    var selectedEntry: Entries? {
        didSet {
            if let entry = selectedEntry {
                let cantoWordText = NSMutableAttributedString(string: entry.cantoWord, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 25), NSAttributedStringKey.foregroundColor: UIColor.cantoDarkBlue(a: 1)])
                if entry.classifier != "" {
                    cantoWordText.append(NSAttributedString(string: " (cl:\(entry.classifier))", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.cantoDarkBlue(a: 1)]))
                }
                
                
                cantoWordLabel.attributedText = cantoWordText
                jyutpingLabel.text = entry.jyutping
                englishWordLabel.text = "En: \(entry.englishWord)"
                mandarinWordLabel.text = "普: \(entry.mandarinWord)"
            }
        }
    }
    
    
    let cantoWordLabel: UITextView = {
        let label = UITextView()
        label.isEditable = false
        label.isScrollEnabled = false
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.cantoWhite(a: 1)
        return label
    }()
    
    let englishWordLabel: UITextView = {
        let label = UITextView()
        label.isEditable = false
        label.isScrollEnabled = false
        label.isUserInteractionEnabled = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = UIColor.cantoWhite(a: 1)
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        return label
    }()
    
    let mandarinWordLabel: UITextView = {
        let label = UITextView()
        label.isEditable = false
        label.isScrollEnabled = false
        label.isUserInteractionEnabled = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = UIColor.cantoWhite(a: 1)
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        return label
    }()
    
    let jyutpingLabel: UITextView = {
        let label = UITextView()
        label.isEditable = false
        label.isScrollEnabled = false
        label.isUserInteractionEnabled = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = UIColor.cantoWhite(a: 1)
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
        let view3 = UIView()
        view3.backgroundColor = .blue
        
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
        
        NSLayoutConstraint.activate([
            
            cellStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            cellStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            cellStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            cellStackView.heightAnchor.constraint(equalToConstant: 89),
            
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
            ])


//
//        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
//
//        addConstraintsWithFormat(format: "H:|-16-[v0]-8-[v1(80)]", views: cantoWordLabel, classifierLabel)
//        addConstraintsWithFormat(format: "H:|-16-[v0]-8-[v1(80)]", views: jyutpingLabel, wordTypeLabel)
//        addConstraintsWithFormat(format: "H:|-\(halfCellWidth)-[v0]-16-|", views: englishWordLabel)
//        addConstraintsWithFormat(format: "H:|-\(halfCellWidth)-[v0]-16-|", views: mandarinWordLabel)
//
//        addConstraintsWithFormat(format: "V:|-16-[v0(25)]-8-[v1(25)]-15-[v2(1)]", views: cantoWordLabel, jyutpingLabel, separatorView)
//        addConstraintsWithFormat(format: "V:|-16-[v0(25)]-8-[v1(25)]-16-|", views: classifierLabel, wordTypeLabel)
//        addConstraintsWithFormat(format: "V:|-16-[v0(25)]-8-[v1(25)]-16-|", views: englishWordLabel, mandarinWordLabel)

        
        
        
    }
   
}

















