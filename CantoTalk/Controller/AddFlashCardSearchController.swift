//
//  AddFlashCardSearchController.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 2/10/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit
import RealmSwift

class AddFlashCardSearchController: SearchController, CustomAlertViewDelegate {
    
    let mainRealm = try! Realm(configuration: Realm.Configuration(fileURL: Bundle.main.url(forResource: "default", withExtension: "realm"), readOnly: true))
    var flashCards: List<FlashCard>?
    
    lazy var bottomBarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.cantoPink(a: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSave)))
        return view
    }()
    
    let bottomBarText: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.cantoWhite(a: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var selectedCardDeck: FlashCardDeck? {
        didSet {
            collectionView.reloadData()
            guard let deck = selectedCardDeck else {return}
            flashCards = deck.cards
            deckTitle = deck.deckTitle
            updateTitle()
            
            for card in deck.cards {
                initialCardIDs.append(card.entryID)
                cardIDs.append(card.entryID)
            }
            numberOfCardsToStart = cardIDs.count
            collectionView.reloadData()
        }
    }
    
    var isShowingCheckedEntries: Bool = false
    var deckTitle: String = ""
    var numberOfCardsToStart: Int = 0
    var initialCardIDs = [Int]()
    var cardIDs = [Int]()
    var timer: Timer!
    var saveButtonPressed: Bool = false
    var bottomBarBottomConstraint: NSLayoutConstraint!
    var bottomBarTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(FlashCardSearchCells.self, forCellWithReuseIdentifier: cellID)
    }
    
    override func setupViews() {
        super.setupViews()
        setupBottomBar()
        searchBarButton.setBackgroundImage(UIImage(named: "checkMark")?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if cardIDs.count == 0 {
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(presentAlert), userInfo: nil, repeats: false)
        }
    }
    
    
    private func setupBottomBar() {
        view.addSubview(bottomBarView)
        bottomBarView.addSubview(bottomBarText)
        
        bottomBarBottomConstraint = bottomBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        bottomBarTopConstraint = bottomBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        
        NSLayoutConstraint.activate([
            bottomBarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            bottomBarView.heightAnchor.constraint(equalToConstant: 60),
            bottomBarTopConstraint,
            
            bottomBarText.topAnchor.constraint(equalTo: bottomBarView.topAnchor),
            bottomBarText.leadingAnchor.constraint(equalTo: bottomBarView.leadingAnchor),
            bottomBarText.trailingAnchor.constraint(equalTo: bottomBarView.trailingAnchor),
            bottomBarText.bottomAnchor.constraint(equalTo: bottomBarView.bottomAnchor)
            ])
    }

    //MARK: - CollectionView Methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isShowingCheckedEntries {
            return cardIDs.count
        } else {
            return entries?.count ?? 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isShowingCheckedEntries {
            let entry = cardIDs[indexPath.item]
            didUnselectEntry(entryID: entry)
        } else {
            guard let entry = entries?[indexPath.item].entryID else {return}
            if cardIDs.contains(entry) {
                didUnselectEntry(entryID: entry)
            } else {
                didSelectEntry(entryID: entry)
            }
        }
        moveBottomBar()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! FlashCardSearchCells
        
        if isShowingCheckedEntries {
            let flashEntry = cardIDs[indexPath.item]
            if let entry = entries?.filter("entryID = %@", flashEntry).first {
                cell.selectedEntry = entry
                updateCellFormat(entry: entry, cell: cell)
            }
            
        } else {
            if let entry = entries?[indexPath.item] {
                cell.selectedEntry = entry
                updateCellFormat(entry: entry, cell: cell)
            }
        }
        
        return cell
    }
    
    private func setupNavBar() {
        guard let navBar = navigationController?.navigationBar else {return}
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.cantoWhite(a: 1)]
    }
    
    
    //MARK: - Data Manipulation Methods
    
    @objc func handleSave() {
        saveButtonPressed = true
        guard let deck = selectedCardDeck else {return}

        for card in cardIDs {
            if initialCardIDs.contains(card) {
                
            } else {
                try! userRealm.write {
                    let newFlashCard = FlashCard()
                    newFlashCard.entryID = card
                    newFlashCard.dateAdded = Date()
                    deck.cards.append(newFlashCard)
                }
            }
        }
        for card in initialCardIDs {
            if cardIDs.contains(card) {
                
            } else {
                guard let flashCardEntry = flashCards?.filter("entryID = %@", card).first else {return}
                try! userRealm.write {
                    userRealm.delete(flashCardEntry)
                }
            }
        }
        updateProgress()
        self.navigationController?.popViewController(animated: true)
    }
    
    private func updateTitle() {
        navigationItem.title = "\"\(deckTitle)\" Card Deck"
    }

    
    private func didSelectEntry(entryID: Int) {
        cardIDs.append(entryID)
        updateTitle()
        
    }
    
    private func didUnselectEntry(entryID: Int) {
        if let index = cardIDs.index(of: entryID) {
            cardIDs.remove(at: index)
        }
        updateTitle()
        
    }
    
    private func updateCellFormat(entry: Entries, cell: FlashCardSearchCells) {
        if cardIDs.contains(entry.entryID) {
            cell.backgroundColor = UIColor.cantoPink(a: 0.2)
            cell.checkMarkView.alpha = 1
        } else {
            cell.backgroundColor = UIColor.cantoWhite(a: 1)
            cell.checkMarkView.alpha = 0
        }
    }
    
    override func handleSearchBarButton() {
        resetEntriesList()
        isShowingCheckedEntries = !isShowingCheckedEntries
        UISearchBar.resignIfFirstResponder(searchBar: searchBar)
        searchBar.text = ""
        searchBarButton.tintColor = isShowingCheckedEntries ? UIColor.cantoPink(a: 1) : UIColor.cantoWhite(a: 1)
        view.layoutIfNeeded()
        collectionView.reloadData()
        guard isShowingCheckedEntries else {return}
        guard cardIDs.count != 0 else {return}
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
    }
    
    private func updateProgress() {
        var deckProgress: CGFloat = 0
        guard let cards = flashCards else {return}
        for card in cards {
            deckProgress += card.cardProgress
        }
        guard let deck = selectedCardDeck else {return}
        let progressPercent = deckProgress * 100 / CGFloat(cards.count)
        try! userRealm.write {
            deck.progress = Int(progressPercent)
        }
    }
    
    //MARK: - Search Methods
    
    override func resetEntriesList() {
        entries = mainRealm.objects(Entries.self)
        collectionView.reloadData()
    }
    
    override func hideHistoryView() {
        isShowingCheckedEntries = false
        searchBarButton.tintColor = UIColor.cantoWhite(a: 1)
        loadData()
    }
    
    
    private func moveBottomBar() {
        if cardIDs.containsSameElements(as: initialCardIDs) {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.bottomBarTopConstraint.isActive = true
                self.bottomBarBottomConstraint.isActive = false
                self.view.layoutIfNeeded()
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.bottomBarTopConstraint.isActive = false
                self.bottomBarBottomConstraint.isActive = true
                self.view.layoutIfNeeded()
            }, completion: nil)
            let cardCount = cardIDs.count
            bottomBarText.text = "Update Cards - \(cardCount) Total"
        }
        collectionView.reloadData()
    }
    
    
    //MARK: - Alert Methods
    
    @objc func presentAlert() {
        let customAlert = CustomAlertController.instantiate(type: .editCards)
        customAlert.delegate = self
        self.present(customAlert, animated: true, completion: nil)
    }
    
    func affirmativeButtonTapped(alertType: Int, textFieldValue: String) {
        print("alert dismissed")
    }
    
    func cancelButtonTapped() {
        print("")
    }

}
