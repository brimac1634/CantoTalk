//
//  LearningKey.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 3/9/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit
import RealmSwift

class FlashCardDeckController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CustomAlertViewDelegate {
    
    let mainRealm = try! Realm(configuration: Realm.Configuration(fileURL: Bundle.main.url(forResource: "default", withExtension: "realm"), readOnly: true))

    let userRealm = try! Realm()
    let alert = CustomAlertController()
    
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
    
    lazy var emptyCard: EmptyDeckView = {
        let view = EmptyDeckView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cellID = "cellID"
    var cellWidth: CGFloat = 0
    var currentDeckSelected: Int = 0
    var cardDecks: Results<FlashCardDeck>?
    let slideUpViewController = SlideUpViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupViews()
    }
    
    func loadData() {
        cardDecks = userRealm.objects(FlashCardDeck.self).sorted(byKeyPath: "dateAdded", ascending: false)
        collectionView.reloadData()
    }
    
    func setupViews() {
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
        emptyCard.addTarget(self, action: #selector(handleNewDeck), for: .touchUpInside)
    }
    
    
    //MARK: - Collection View Methods

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let slideUpOtions = SlideUpOptionView()
        slideUpOtions.flashCardDeckController = self
        slideUpViewController.showEntryView(slideUpView: slideUpOtions, viewHeight: slideUpOtions.viewHeight + 50)
        currentDeckSelected = indexPath.item - 1
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardDecks?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! FlashCardDeckCell
        if indexPath.item == 0 {
            cell.alpha = 0
        } else {
            if let decks = cardDecks?.sorted(byKeyPath: "dateAdded", ascending: false) {
                cell.cardDeck = decks[indexPath.item - 1]
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return view.frame.width / 8
    }
    
    //MARK: - Create new deck
    
    @objc func handleNewDeck() {
        let customAlert = CustomAlertController.instantiate(type: .create)
        customAlert.delegate = self
        self.present(customAlert, animated: true, completion: nil)
    }
    
    
    func affirmativeButtonTapped(alertType: Int, textFieldValue: String) {
        switch alertType {
        case 0:
            try! userRealm.write {
                let newDeck = FlashCardDeck()
                newDeck.deckTitle = textFieldValue
                newDeck.dateAdded = Date()
                userRealm.add(newDeck)
            }
        case 1:
            try! userRealm.write {
                guard let deck = cardDecks?[currentDeckSelected] else {return}
                deck.deckTitle = textFieldValue
            }
        case 2:
            try! userRealm.write {
                guard let deck = cardDecks?[currentDeckSelected] else {return}
                userRealm.delete(deck)
            }
        default:
            print("nothing to do")
            
        }
        
        loadData()
    }
    
    func cancelButtonTapped() {
        print("cancelButtonTapped")
    }

    //MARK: - Navigational Method
    
    func cardDeckOptionHandler(index: Int) {
        slideUpViewController.handleDismiss()
        switch index {
        case 0:
            let flashCardSwipeController = FlashCardSwipeController()
            if let cardDeck = cardDecks {
                flashCardSwipeController.flashCardList = cardDeck[currentDeckSelected].cards
            }
            navigationController?.navigationBar.barTintColor = UIColor.cantoWhite(a: 1)
            navigationController?.navigationBar.tintColor = UIColor.cantoDarkBlue(a: 1)
            navigationController?.pushViewController(flashCardSwipeController, animated: true)
        case 1:
            let addFlashCardController = AddFlashCardSearchController()
            if let cardDeck = cardDecks {
                addFlashCardController.selectedCardDeck = cardDeck[currentDeckSelected]
                addFlashCardController.entries = mainRealm.objects(Entries.self)
            }
            navigationController?.pushViewController(addFlashCardController, animated: true)
        case 2:
            let customAlert = CustomAlertController.instantiate(type: .rename)
            customAlert.delegate = self
            self.present(customAlert, animated: true, completion: nil)
        case 3:
            let customAlert = CustomAlertController.instantiate(type: .delete)
            customAlert.delegate = self
            self.present(customAlert, animated: true, completion: nil)
        default:
            print("Nothing to do")
        }
    }

}
