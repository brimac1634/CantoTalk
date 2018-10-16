//
//  FlashCardDeckCell.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 26/9/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class FlashCardDeckCell: BaseCell {
    
    var cardDeck: FlashCardDeck? {
        didSet {
            guard let deck = cardDeck else {return}
            deckTitle.text = deck.deckTitle
        }
    }
    
    let card: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.cantoWhite(a: 1)
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.dropShadow()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backgroundImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "WaveBackground"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.alpha = 0.9
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let numberOfCardsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.cantoPink(a: 1)
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    let percentLearned: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.cantoPink(a: 1)
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    let deckTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = UIColor.cantoWhite(a: 1)
        
        addSubview(card)
        card.addSubview(backgroundImage)
//        card.addSubview(deckImage)
        addSubview(deckTitle)
        
        NSLayoutConstraint.activate([
            deckTitle.bottomAnchor.constraint(equalTo: bottomAnchor),
            deckTitle.widthAnchor.constraint(equalTo: widthAnchor),
            deckTitle.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            
            card.centerXAnchor.constraint(equalTo: centerXAnchor),
            card.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            card.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            card.bottomAnchor.constraint(equalTo: deckTitle.topAnchor),
            
            backgroundImage.topAnchor.constraint(equalTo: card.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: card.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: card.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: card.bottomAnchor),
            
//            deckImage.widthAnchor.constraint(equalTo: card.widthAnchor, multiplier: 0.6),
//            deckImage.heightAnchor.constraint(equalTo: card.widthAnchor, multiplier: 0.6),
//            deckImage.centerXAnchor.constraint(equalTo: card.centerXAnchor),
//            deckImage.centerYAnchor.constraint(equalTo: card.centerYAnchor)
            ])
        
    }
}
