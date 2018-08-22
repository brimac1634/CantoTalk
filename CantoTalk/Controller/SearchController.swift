//
//  SearchControllerViewController.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 9/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit
import RealmSwift

class SearchController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.cantoWhite(a: 1)
        return cv
    }()
    
    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "English/Cantonese/Mandarin/Jyutping"
        bar.barTintColor = UIColor.cantoDarkBlue(a: 1)
        bar.tintColor = UIColor.cantoPink(a: 1)
        bar.autocorrectionType = .yes
        bar.delegate = self
        return bar
    }()
    
    var entries: Results<Entries>? {
        didSet {
            loadData()
        }
    }
    
    let cellID = "cellID"
    var homeController: HomeController?
    let slideUpViewController = SlideUpViewController()
    
    
    override func viewDidLoad() {
        
        
        
        collectionView.register(WordCells.self, forCellWithReuseIdentifier: cellID)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: searchBar)
        view.addConstraintsWithFormat(format: "V:|[v0(45)][v1]|", views: searchBar, collectionView)
        
        loadData()
    }
    
    func loadData() {
        collectionView.reloadData()
    }
    

    //MARK: - CollectionView Methods
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if searchBar.isFirstResponder == true {
            searchBar.resignFirstResponder()
        }
        let view = EntryView()
        if let entry = entries?[indexPath.item] {
            view.selectedEntry = entry
            slideUpViewController.showEntryView(slideUpView: view)
            return
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entries?.count ?? 0
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! WordCells
        if let entry = entries?[indexPath.item] {
            cell.selectedEntry = entry
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 90)
    }
    
    //MARK: - SearchBar Methods

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        entries = entries?.filter("jyutping CONTAINS[cd] %@ OR englishWord CONTAINS[cd] %@ OR cantoWord CONTAINS[cd] %@ OR mandarinWord CONTAINS[cd] %@", searchBar.text!, searchBar.text!, searchBar.text!, searchBar.text!).sorted(byKeyPath: "englishWord", ascending: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        if searchBar.text?.count == 0 {
            entries = homeController?.mainRealm.objects(Entries.self)
        } else {
            entries = entries?.filter("jyutping CONTAINS[cd] %@ OR englishWord CONTAINS[cd] %@ OR cantoWord CONTAINS[cd] %@ OR mandarinWord CONTAINS[cd] %@", searchBar.text!, searchBar.text!, searchBar.text!, searchBar.text!).sorted(byKeyPath: "englishWord", ascending: true)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        entries = homeController?.mainRealm.objects(Entries.self)
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        
    }
    
    
    
}
