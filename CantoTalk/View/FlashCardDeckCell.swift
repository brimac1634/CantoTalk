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
            numberOfCardsLabel.text = "\(deck.cards.count) Cards"
            percentLearned.text = "\(deck.progress)%"
            progressBarWidthAnchor.constant = CGFloat(deck.progress) * progressBarWidth / 100
        }
    }
    
    var progressBarWidth: CGFloat = 0
    var progressBarWidthAnchor: NSLayoutConstraint!
    
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
        image.alpha = 0.3
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let numberOfCardsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    let percentLearned: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    let progressBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.cantoLightBlue(a: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
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
        
        let cardStackView = UIStackView(arrangedSubviews: [numberOfCardsLabel, percentLearned])
        cardStackView.translatesAutoresizingMaskIntoConstraints = false
        cardStackView.axis = .vertical
        cardStackView.distribution = .fillEqually
        
        backgroundColor = UIColor.cantoWhite(a: 1)
        
        addSubview(card)
        card.addSubview(backgroundImage)
        card.addSubview(cardStackView)
        card.addSubview(progressBar)
        addSubview(deckTitle)
        
        progressBarWidthAnchor = progressBar.widthAnchor.constraint(equalToConstant: 50)
        progressBarWidth = frame.width * 0.6
        let leadingConstant: CGFloat = (frame.width - progressBarWidth) / 2
        
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
            
            cardStackView.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            cardStackView.centerYAnchor.constraint(equalTo: card.centerYAnchor, constant: -15),
            cardStackView.widthAnchor.constraint(equalTo: card.widthAnchor, multiplier: 0.9),
            cardStackView.heightAnchor.constraint(equalTo: card.heightAnchor, multiplier: 0.5),
            
            progressBar.heightAnchor.constraint(equalToConstant: 10),
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingConstant),
            progressBarWidthAnchor,
            progressBar.topAnchor.constraint(equalTo: cardStackView.bottomAnchor, constant: 8)
            ])
        
        
        
    }
}
