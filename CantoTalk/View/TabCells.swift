//
//  TabCells.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 7/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit
import RealmSwift

class TabCells: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    let realm = try! Realm(configuration: Realm.Configuration(fileURL: Bundle.main.url(forResource: "default", withExtension: "realm"), readOnly: true))
    let favoritesRealm = try! Realm()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.blue
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let wordCellID = "wordCellID"
    let pageCellID = "pageCellID"
    
    override func setupViews() {
        collectionView.register(WordCells.self, forCellWithReuseIdentifier: wordCellID)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: pageCellID)
        addSubview(collectionView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item < 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: wordCellID, for: indexPath) as! WordCells
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pageCellID, for: indexPath)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item < 2 {
            return CGSize(width: frame.width, height: 90)
        } else {
            return CGSize(width: frame.width, height: frame.height)
        }
    }
    
}
