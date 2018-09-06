//
//  TabCells.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 7/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit
import RealmSwift

class FavoritesController: SearchController  {
    
    let mainRealm = try! Realm(configuration: Realm.Configuration(fileURL: Bundle.main.url(forResource: "default", withExtension: "realm"), readOnly: true))
    
    var favoritesEntries: Results<Favorites>? {
        didSet {
            loadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
  
        blueView.isHidden = true
        historyButton.isHidden = true
        
        searchTrailing.constant = 0
        
        searchBar.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    //MARK: - CollectionView Methods
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if searchBar.isFirstResponder == true {
            searchBar.resignFirstResponder()
        }
        
        let view = EntryView()
        if let selectedFavoriteEntry = favoritesEntries?[indexPath.item] {
            if let entry = mainRealm.objects(Entries.self).filter("entryID = \(selectedFavoriteEntry.entryID)").first {
                view.selectedEntry = entry
                view.favoritesController = self
                slideUpViewController.showEntryView(slideUpView: view)
                return
            }
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesEntries?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! WordCells
        if let entry = favoritesEntries?[indexPath.item] {
            if let entry = mainRealm.objects(Entries.self).filter("entryID = \(entry.entryID)").first {
                cell.selectedEntry = entry
            }
        }
        return cell
    }
    
    //MARK: - SearchBar Methods
    
    override func searchWithFilter() {
        favoritesEntries = favoritesEntries?.filter("jyutping CONTAINS[cd] %@ OR englishWord CONTAINS[cd] %@ OR cantoWord CONTAINS[cd] %@ OR mandarinWord CONTAINS[cd] %@", searchBar.text!, searchBar.text!, searchBar.text!, searchBar.text!).sorted(byKeyPath: "dateFavorited", ascending: false)
    }
    
    override func resetEntriesList() {
        super.resetEntriesList()
    }
    

}
