//
//  FlashCardView.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 5/10/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class FlashCardView: BaseView {
    
    var showEnglishFirst: Bool = true
    
    var flashCard: FlashCard? {
        didSet {
            
        }
    }
    
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.cantoWhite(a: 1)
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.dropShadow()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let englishLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(cardView)
        addSubview(englishLabel)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            englishLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            englishLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            englishLabel.widthAnchor.constraint(equalTo: widthAnchor),
            englishLabel.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
}
