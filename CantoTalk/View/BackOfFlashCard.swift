//
//  BackOfFlashCard.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 9/10/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class BackOfFlashCard: EntryView {
    
    override func handleEntry(entry: Entries) {
        super.handleEntry(entry: entry)
        
        let topText = NSMutableAttributedString(string: entry.cantoWord, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 38), NSAttributedString.Key.foregroundColor: UIColor.cantoWhite(a: 1)])
        if entry.classifier != "" {
            topText.append(NSAttributedString(string: " (cl:\(entry.classifier))", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.cantoWhite(a: 1)]))
        }
        topText.append(NSAttributedString(string: "\n\(entry.jyutping)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26), NSAttributedString.Key.foregroundColor: UIColor.cantoWhite(a: 1)]))
        
        
        cantoWordLabel.attributedText = topText
    }
    
    override func setupView() {
        
        translatesAutoresizingMaskIntoConstraints = false
        cantoWordLabel.textAlignment = .center
        cantoWordLabel.backgroundColor = UIColor.cantoDarkBlue(a: 1)
        speakerButton.normalColor = UIColor.cantoWhite(a: 1)
        
        backgroundColor = UIColor.cantoDarkBlue(a: 1)
        
        addSubview(cantoWordLabel)
        addSubview(speakerButton)
        
        NSLayoutConstraint.activate([
            
            speakerButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            speakerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            speakerButton.widthAnchor.constraint(equalToConstant: 40),
            speakerButton.heightAnchor.constraint(equalToConstant: 40),
            
            cantoWordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            cantoWordLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            cantoWordLabel.trailingAnchor.constraint(equalTo: speakerButton.leadingAnchor, constant: -8),
            cantoWordLabel.heightAnchor.constraint(equalToConstant: 140),
            
            
            ])

    }
}
