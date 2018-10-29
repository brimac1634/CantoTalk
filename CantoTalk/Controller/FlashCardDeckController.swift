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
    
    lazy var whiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.cantoWhite(a: 1)
        return view
    }()
    
    lazy var emptyCard: EmptyDeckView = {
        let view = EmptyDeckView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cellID = "cellID"
    var cellWidth: CGFloat = 0
    var cellHeight: CGFloat = 0
    var currentDeckSelected: Int = 0
    var cardDecks: Results<FlashCardDeck>?
    var numberOfCells: Int!
    let slideUpViewController = SlideUpViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let backButton = UIBarButtonItem()
        backButton.title = "Save"
        navigationItem.backBarButtonItem = backButton
    }
    
    func loadData() {
        cardDecks = userRealm.objects(FlashCardDeck.self).sorted(byKeyPath: "dateAdded", ascending: false)
        numberOfCells = cardDecks?.count
        if numberOfCells != nil {
            numberOfCells += 1
        }
        collectionView.reloadData()
    }
    
    func setupViews() {
        view.backgroundColor = UIColor.cantoWhite(a: 1)
        cellWidth = view.frame.width / 2.5
        cellHeight = cellWidth * 1.3
        
        view.addSubview(collectionView)
        collectionView.addSubview(whiteView)
        collectionView.addSubview(emptyCard)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            whiteView.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: -10),
            whiteView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: -5),
            whiteView.widthAnchor.constraint(equalToConstant: cellWidth + 5),
            whiteView.heightAnchor.constraint(equalToConstant: cellHeight + 5),
            
            emptyCard.topAnchor.constraint(equalTo: collectionView.topAnchor),
            emptyCard.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            emptyCard.widthAnchor.constraint(equalToConstant: cellWidth),
            emptyCard.heightAnchor.constraint(equalToConstant: cellHeight)
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
        return numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
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
            openAddCardController()
        case 1:
            try! userRealm.write {
                guard let deck = cardDecks?[currentDeckSelected] else {return}
                deck.deckTitle = textFieldValue
            }
        case 2:
            openAddCardController()
        case 3:
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
            guard let cardDeck = cardDecks else {return}
            if cardDeck[currentDeckSelected].cards.count != 0{
                let flashCardSwipeController = FlashCardSwipeController()
                flashCardSwipeController.flashCardDeck = cardDeck[currentDeckSelected]
                navigationController?.isNavigationBarHidden = true
                navigationController?.pushViewController(flashCardSwipeController, animated: true)
            } else {
                let customAlert = CustomAlertController.instantiate(type: .addCards)
                customAlert.delegate = self
                self.present(customAlert, animated: true, completion: nil)
            }
        case 1:
            openAddCardController()
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
    
    private func openAddCardController() {
        let addFlashCardController = AddFlashCardSearchController()
        if let cardDeck = cardDecks {
            addFlashCardController.selectedCardDeck = cardDeck[currentDeckSelected]
            addFlashCardController.entries = mainRealm.objects(Entries.self)
        }
        navigationController?.pushViewController(addFlashCardController, animated: true)
    }


}
