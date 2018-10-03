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
        bar.tintColor = UIColor.lightGray
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
    
    let searchBarButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "history")?.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(image, for: .normal)
        button.backgroundColor = UIColor.cantoDarkBlue(a: 1)
        button.tintColor = UIColor.cantoWhite(a: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSearchBarButton), for: .touchUpInside)
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
    var searchTrailing: NSLayoutConstraint!
    
    override func viewDidLoad() {
        
        collectionView.register(WordCells.self, forCellWithReuseIdentifier: cellID)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap))
        collectionView.backgroundView = UIView(frame: collectionView.bounds)
        collectionView.backgroundView?.addGestureRecognizer(tapGesture)
    
        setupViews()
        
        loadData()
    }
    
    func loadData() {
        recentlyViewed = userRealm.objects(RecentlyViewedItems.self).sorted(byKeyPath: "dateViewed", ascending: false)
        collectionView.reloadData()
    }
    
    func setupViews() {
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        view.addSubview(blueView)
        view.addSubview(searchBarButton)
        view.addSubview(fadedView)
        
        searchTrailing = searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45)
        
        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchTrailing,
            searchBar.heightAnchor.constraint(equalToConstant: 45),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            blueView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            blueView.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            blueView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blueView.heightAnchor.constraint(equalToConstant: 45),
            
            searchBarButton.widthAnchor.constraint(equalToConstant: 28),
            searchBarButton.heightAnchor.constraint(equalToConstant: 28),
            searchBarButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            searchBarButton.centerXAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
            
            fadedView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            fadedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fadedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fadedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
            ])
        
        fadedView.isHidden = true
    }
    
    //MARK: - CollectionView Methods

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UISearchBar.resignIfFirstResponder(searchBar: searchBar)
        
        let entryView = EntryView()
        
        if isHistoryShowing == false {
            if let entry = entries?[indexPath.item] {
                entryView.selectedEntry = entry
                slideUpViewController.showEntryView(slideUpView: entryView)
                do {
                    try userRealm.write {
                        let recentlyViewedItem = RecentlyViewedItems()
                        recentlyViewedItem.entryID = entry.entryID
                        let date = Date()
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "y-MM-dd H:m:ss"
                        let dateString = dateFormatter.string(from: date)
                        recentlyViewedItem.dateViewed = dateString
                        userRealm.add(recentlyViewedItem)
                    }
                } catch {
                    print("error saving searchedItem: \(error)")
                }
                return
            }
        } else {
            if let recent = recentlyViewed?[indexPath.item] {
                if let entry = homeController?.mainRealm.objects(Entries.self).filter("entryID = \(recent.entryID)").first {
                    entryView.selectedEntry = entry
                    slideUpViewController.showEntryView(slideUpView: entryView)
                }
            }
        }

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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if searchBar.isFirstResponder == true {
            searchBar.resignFirstResponder()
        }
    }
    
    @objc func handleBackgroundTap() {
        UISearchBar.resignIfFirstResponder(searchBar: searchBar)
    }
    
    
    //MARK: - SearchBar Methods

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        hideHistoryView()
        searchWithFilter()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            resetEntriesList()
        } else {
            hideHistoryView()
            resetEntriesList()
            searchWithFilter()
        }
    }
    
    func searchWithFilter() {
        entries = entries?.filter("jyutping CONTAINS[cd] %@ OR englishWord CONTAINS[cd] %@ OR cantoWord CONTAINS[cd] %@ OR mandarinWord CONTAINS[cd] %@", searchBar.text!, searchBar.text!, searchBar.text!, searchBar.text!).sorted(byKeyPath: "englishWord", ascending: true)
    }


    //MARK: - History Methods
    
    @objc func handleSearchBarButton() {
        UISearchBar.resignIfFirstResponder(searchBar: searchBar)
        searchBar.text = ""
        resetEntriesList()
        if isHistoryShowing == false {
            showHistoryView()
        } else {
            hideHistoryView()
        }
    }
    
    func showHistoryView() {
        fadedView.isHidden = false
        searchBarButton.tintColor = UIColor.cantoPink(a: 1)
        loadData()
        isHistoryShowing = true
        collectionView.reloadData()
        guard recentlyViewed?.count != 0 else {return}
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
    }
    
    func hideHistoryView() {
        fadedView.isHidden = true
        searchBarButton.tintColor = UIColor.cantoWhite(a: 1)
        isHistoryShowing = false
        loadData()
    }
    
    func resetEntriesList() {
        homeController?.loadData()
    }
    
}
