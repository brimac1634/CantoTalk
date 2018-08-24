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
    
    var favoritesEntries: Results<Entries>? {
        didSet {
            loadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
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
            cell.selectedEntry = entry
        }
        return cell
    }
    
    //MARK: - SearchBar Methods
    
    override func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        favoritesEntries = favoritesEntries?.filter("jyutping CONTAINS[cd] %@ OR englishWord CONTAINS[cd] %@ OR cantoWord CONTAINS[cd] %@ OR mandarinWord CONTAINS[cd] %@", searchBar.text!, searchBar.text!, searchBar.text!, searchBar.text!).sorted(byKeyPath: "englishWord", ascending: true)
    }
    
    override func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        if searchBar.text?.count == 0 {
            favoritesEntries = homeController?.userRealm.objects(Entries.self)
        } else {
            favoritesEntries = favoritesEntries?.filter("jyutping CONTAINS[cd] %@ OR englishWord CONTAINS[cd] %@ OR cantoWord CONTAINS[cd] %@ OR mandarinWord CONTAINS[cd] %@", searchBar.text!, searchBar.text!, searchBar.text!, searchBar.text!).sorted(byKeyPath: "englishWord", ascending: true)
        }
    }
    

}
