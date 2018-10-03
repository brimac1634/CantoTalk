//
//  AddFlashCardSearchController.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 2/10/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit
import RealmSwift

class AddFlashCardSearchController: SearchController {
    
    var flashCards: List<FlashCard>?
    
    var selectedCardDeck: FlashCardDeck? {
        didSet {
            loadData()
            flashCards = selectedCardDeck?.cards
        }
    }
    
    var isShowingCheckedEntries: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(FlashCardSearchCells.self, forCellWithReuseIdentifier: cellID)
    }
    
    override func setupViews() {
        super.setupViews()
        
        searchBarButton.setBackgroundImage(UIImage(named: "checkMark"), for: .normal)
    }

    //MARK: - CollectionView Methods
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let entry = entries?[indexPath.item] else {return}
        if flashCards?.filter("entryID = %@", entry.entryID).first != nil {
            didUnselectEntry(entry: entry)
        } else {
            didSelectEntry(entry: entry)
        }
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! FlashCardSearchCells
        if let entry = entries?[indexPath.item] {
            cell.selectedEntry = entry
            cell.flashCards = selectedCardDeck?.cards
            if flashCards?.filter("entryID = %@", entry.entryID).first != nil {
                cell.backgroundColor = UIColor.lightGray
                cell.checkMarkView.alpha = 1
            } else {
                cell.backgroundColor = UIColor.cantoWhite(a: 1)
                cell.checkMarkView.alpha = 0
            }
        }
        
        return cell
    }

    
    private func didSelectEntry(entry: Entries) {
        guard flashCards?.filter("entryID = %@", entry.entryID).first == nil else {return}
        try! userRealm.write {
            let newFlashCard = FlashCard()
            newFlashCard.entryID = entry.entryID
            newFlashCard.dateAdded = Date()
            selectedCardDeck?.cards.append(newFlashCard)
        }
        collectionView.reloadData()
        
    }
    
    private func didUnselectEntry(entry: Entries) {
        guard let flashCardEntry = flashCards?.filter("entryID = %@", entry.entryID).first else {return}
        try! userRealm.write {
            userRealm.delete(flashCardEntry)
        }
    }
    
    override func handleSearchBarButton() {
        isShowingCheckedEntries = !isShowingCheckedEntries
        UISearchBar.resignIfFirstResponder(searchBar: searchBar)
        searchBar.text = ""
        searchBarButton.tintColor = isShowingCheckedEntries ? UIColor.cantoPink(a: 1) : UIColor.cantoWhite(a: 1)
        
    }
}
