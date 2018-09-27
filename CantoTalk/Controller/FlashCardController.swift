//
//  LearningKey.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 3/9/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit
import RealmSwift

class FlashCardController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let userRealm = try! Realm()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.cantoWhite(a: 1)
        cv.contentInset = UIEdgeInsets(top: 32, left: 32, bottom: 32, right: 32)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    lazy var emptyCard: FlashCardDeckCell = {
        let view = FlashCardDeckCell()
        view.card2.alpha = 0
        view.deckImage.image = UIImage(named: "add")?.withRenderingMode(.alwaysTemplate)
        view.deckImage.tintColor = UIColor.cantoDarkBlue(a: 1)
        view.deckImage.alpha = 1
        view.deckTitle.text = "Create New Deck"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cellID = "cellID"
    var cellWidth: CGFloat = 0
    var cardDecks: Results<FlashCardDeck>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cantoWhite(a: 1)
        cellWidth = view.frame.width / 2.5
        
        view.addSubview(collectionView)
        collectionView.addSubview(emptyCard)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyCard.topAnchor.constraint(equalTo: collectionView.topAnchor),
            emptyCard.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            emptyCard.widthAnchor.constraint(equalToConstant: cellWidth),
            emptyCard.heightAnchor.constraint(equalToConstant: cellWidth)
            ])
        
        
        collectionView.register(FlashCardDeckCell.self, forCellWithReuseIdentifier: cellID)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(123)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! FlashCardDeckCell
        if indexPath.item == 0 {
            cell.alpha = 0
        } else {
            if let decks = cardDecks {
                cell.cardDeck = decks[indexPath.item - 1]
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return view.frame.width / 8
    }
    
    
}
