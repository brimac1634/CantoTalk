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
        navigationController?.navigationBar.backItem?.title = "Save Flashcards"
        searchBarButton.setBackgroundImage(UIImage(named: "checkMark")?.withRenderingMode(.alwaysTemplate), for: .normal)
    }

    //MARK: - CollectionView Methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isShowingCheckedEntries {
            return flashCards?.count ?? 0
        } else {
            return entries?.count ?? 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isShowingCheckedEntries {
            guard let flashEntry = flashCards?[indexPath.item] else {return}
            guard let entry = entries?.filter("entryID = %@", flashEntry.entryID).first else {return}
            didUnselectEntry(entry: entry)
        } else {
            guard let entry = entries?[indexPath.item] else {return}
            if flashCards?.filter("entryID = %@", entry.entryID).first != nil {
                didUnselectEntry(entry: entry)
            } else {
                didSelectEntry(entry: entry)
            }
            collectionView.reloadData()
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! FlashCardSearchCells
        
        if isShowingCheckedEntries {
            if let flashEntry = flashCards?[indexPath.item] {
                if let entry = entries?.filter("entryID = %@", flashEntry.entryID).first {
                    cell.selectedEntry = entry
                    updateCellFormat(entry: entry, cell: cell)
                }
            }
        } else {
            if let entry = entries?[indexPath.item] {
                cell.selectedEntry = entry
                updateCellFormat(entry: entry, cell: cell)
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
        collectionView.reloadData()
    }
    
    private func updateCellFormat(entry: Entries, cell: FlashCardSearchCells) {
        if flashCards?.filter("entryID = %@", entry.entryID).first != nil {
            cell.backgroundColor = UIColor.lightGray
            cell.checkMarkView.alpha = 1
        } else {
            cell.backgroundColor = UIColor.cantoWhite(a: 1)
            cell.checkMarkView.alpha = 0
        }
    }
    
    override func handleSearchBarButton() {
        isShowingCheckedEntries = !isShowingCheckedEntries
        UISearchBar.resignIfFirstResponder(searchBar: searchBar)
        searchBar.text = ""
        searchBarButton.tintColor = isShowingCheckedEntries ? UIColor.cantoPink(a: 1) : UIColor.cantoWhite(a: 1)
        view.layoutIfNeeded()
        collectionView.reloadData()
        guard isShowingCheckedEntries else {return}
        guard flashCards?.count != 0 else {return}
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
    }
}
