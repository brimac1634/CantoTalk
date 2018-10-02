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

    let mainRealm = try! Realm(configuration: Realm.Configuration(fileURL: Bundle.main.url(forResource: "default", withExtension: "realm"), readOnly: true))
    
    var selectedCardDeck: FlashCardDeck? {
        didSet {
            loadData()
        }
    }
    
    var isShowingCheckedEntries: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    private func setupView() {
//        searchBarButton.setBackgroundImage(UIImage(named: "checkMark"), for: .normal)
    }
    
    override func loadData() {
        entries = mainRealm.objects(Entries.self)
        collectionView.reloadData()
        //preset item cells to selected
    }
    

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //show selected cell and add entry to deck
    }

    
    private func didSelectEntry() {
        
    }
    
    private func didUnselectEntry() {
        
    }
    
    override func handleSearchBarButton() {
        isShowingCheckedEntries = !isShowingCheckedEntries
        UISearchBar.resignIfFirstResponder(searchBar: searchBar)
        searchBar.text = ""
        searchBarButton.tintColor = isShowingCheckedEntries ? UIColor.cantoPink(a: 1) : UIColor.cantoWhite(a: 1)
        
    }
}
