//
//  File.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 27/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit
import RealmSwift

class SearchHistoryView: BaseView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let userRealm = try! Realm()
    var searchedItems: Results<SearchedItems>?
    let cellID = "cellID"
    
    override func setupViews() {
        backgroundColor = UIColor.cantoWhite(a: 1)
        searchedItems = userRealm.objects(SearchedItems.self)
        collectionView.register(SearchHistoryCell.self, forCellWithReuseIdentifier: cellID)
        
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SearchHistoryCell
        if let searchedList = searchedItems {
            cell.wordLabel.text = searchedList[indexPath.item].searchedItem
            cell.dateLabel.text = searchedList[indexPath.item].dateSearched
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 50)
    }
}

class SearchHistoryCell: BaseCell {
    
    let wordLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.cantoLightBlue(a: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [wordLabel, dateLabel])
        stackView.distribution = .fillEqually
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}
