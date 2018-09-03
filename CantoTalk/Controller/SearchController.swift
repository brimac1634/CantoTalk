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
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "English/Cantonese/Mandarin/Jyutping"
        let historyImage = UIImage(named: "history")?.withRenderingMode(.alwaysTemplate)
        bar.barTintColor = UIColor.cantoDarkBlue(a: 1)
        bar.tintColor = UIColor.cantoWhite(a: 1)
        bar.autocorrectionType = .yes
        bar.delegate = self
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.cantoDarkBlue(a: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let historyButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "history")?.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(image, for: .normal)
        button.backgroundColor = UIColor.cantoDarkBlue(a: 1)
        button.tintColor = UIColor.cantoWhite(a: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleHistory), for: .touchUpInside)
        return button
    }()
    
    let fadedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.4)
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    var entries: Results<Entries>? {
        didSet {
            loadData()
        }
    }
    
    let cellID = "cellID"
    let userRealm = try! Realm()
    var recentlyViewed: Results<RecentlyViewedItems>?
    var homeController: HomeController?
    var isHistoryShowing: Bool = false
    let slideUpViewController = SlideUpViewController()
    
    
    override func viewDidLoad() {
        
        collectionView.register(WordCells.self, forCellWithReuseIdentifier: cellID)
    
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        view.addSubview(blueView)
        view.addSubview(historyButton)
        view.addSubview(fadedView)
        
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: -2),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            searchBar.heightAnchor.constraint(equalToConstant: 45),
            
            blueView.topAnchor.constraint(equalTo: view.topAnchor, constant: -2),
            blueView.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            blueView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blueView.heightAnchor.constraint(equalToConstant: 45),
            
            historyButton.widthAnchor.constraint(equalToConstant: 28),
            historyButton.heightAnchor.constraint(equalToConstant: 28),
            historyButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            historyButton.centerXAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
            
            fadedView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            fadedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fadedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fadedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

            ])

        fadedView.isHidden = true
        
        loadData()
    }
    
    func loadData() {
        recentlyViewed = userRealm.objects(RecentlyViewedItems.self).sorted(byKeyPath: "dateViewed", ascending: true)
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
            do {
                try userRealm.write {
                    let recentlyViewedItem = RecentlyViewedItems()
                    recentlyViewedItem.entryID = entry.entryID
                    let date = Date()
                    let dateFormatter = DateFormatter()
                    dateFormatter.timeStyle = DateFormatter.Style.none
                    dateFormatter.dateStyle = DateFormatter.Style.medium
                    let dateString = dateFormatter.string(from: date)
                    recentlyViewedItem.dateViewed = dateString
                    userRealm.add(recentlyViewedItem)
                }
            } catch {
                print("error saving searchedItem: \(error)")
            }
            loadData()
            return
        }
        loadData()

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isHistoryShowing == false {
            return entries?.count ?? 0
        } else {
            return recentlyViewed?.count ?? 0
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! WordCells
        if isHistoryShowing == false {
            if let entry = entries?[indexPath.item] {
                cell.selectedEntry = entry
            }
        } else {
            recentlyViewed = userRealm.objects(RecentlyViewedItems.self).sorted(byKeyPath: "dateViewed", ascending: true)
            if let recent = recentlyViewed?[indexPath.item] {
                if let entry = homeController?.mainRealm.objects(Entries.self).filter("entryID = \(recent.entryID)").first {
                    cell.selectedEntry = entry
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    //MARK: - SearchBar Methods

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        hideHistoryView()
        searchWithFilter()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        if searchBar.text?.count == 0 {
            checkIfHistoryIsOn()
        } else {
            hideHistoryView()
            searchWithFilter()
        }
    }
    
    func searchWithFilter() {
        entries = entries?.filter("jyutping CONTAINS[cd] %@ OR englishWord CONTAINS[cd] %@ OR cantoWord CONTAINS[cd] %@ OR mandarinWord CONTAINS[cd] %@", searchBar.text!, searchBar.text!, searchBar.text!, searchBar.text!).sorted(byKeyPath: "englishWord", ascending: true)
    }

    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        checkIfHistoryIsOn()
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        
    }
    
    func checkIfHistoryIsOn() {
        if isHistoryShowing == false {
            entries = homeController?.mainRealm.objects(Entries.self)
        }
    }
    
    @objc func handleHistory() {
        if isHistoryShowing == false {
            showHistoryView()
        } else {
            hideHistoryView()
        }
    }
    
    func showHistoryView() {
        fadedView.isHidden = false
        historyButton.tintColor = UIColor.cantoPink(a: 1)
        isHistoryShowing = true
        collectionView.reloadData()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
    }
    
    func hideHistoryView() {
        fadedView.isHidden = true
        historyButton.tintColor = UIColor.cantoWhite(a: 1)
        isHistoryShowing = false
        loadData()
    }
    
}
