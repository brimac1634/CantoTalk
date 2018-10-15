//
//  FlashCardView.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 5/10/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit
import RealmSwift

class FlashCardView: BaseView {
    
    let mainRealm = try! Realm(configuration: Realm.Configuration(fileURL: Bundle.main.url(forResource: "default", withExtension: "realm"), readOnly: true))
    
    var showingFront: Bool = true
    var flashCardWidth: NSLayoutConstraint!
    var flashCardHeight: NSLayoutConstraint!
    var flashCardCenterX: NSLayoutConstraint!
    var flashCardCenterY: NSLayoutConstraint!
    
    var flashCard: FlashCard? {
        didSet {
            guard let card = mainRealm.objects(Entries.self).filter("entryID = %@", flashCard?.entryID).first else {return}
            englishLabel.text = card.englishWord
            backView.selectedEntry = card
            backView.speakerButton.cantoWord = card.cantoWord
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
    
    let englishLabel: UITextView = {
        let label = UITextView()
        label.isEditable = false
        label.isSelectable = false
        label.isScrollEnabled = false
        label.font = UIFont.systemFont(ofSize: 38)
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        label.backgroundColor = UIColor.cantoWhite(a: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let backView: BackOfFlashCard = {
        let view = BackOfFlashCard()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(cardView)
        cardView.addSubview(englishLabel)
        cardView.addSubview(backView)
        
        
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            englishLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            englishLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            englishLabel.widthAnchor.constraint(equalTo: widthAnchor),
            englishLabel.heightAnchor.constraint(equalToConstant: 100),
            
            backView.topAnchor.constraint(equalTo: topAnchor),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor),

            ])
        backView.alpha = 0
        
    }
    
    func flip() {
        
        if showingFront {
            
            UIView.transition(with: cardView, duration: 1, options: .transitionFlipFromLeft, animations: {
                self.englishLabel.alpha = 0
                self.backView.alpha = 1
            }, completion: nil)
            showingFront = false
        } else {
            UIView.transition(with: cardView, duration: 1, options: .transitionFlipFromRight, animations: {
                self.englishLabel.alpha = 1
                self.backView.alpha = 0
            }, completion: nil)
            showingFront = true
        }
        
    }
    
}
