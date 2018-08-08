//
//  TabCells.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 7/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit
import RealmSwift

class FavoritesCollectionView: WordCollectionView  {
    
    let favoritesRealm = try! Realm()
    
    override func setupViews() {
        super.setupViews()
    }
    
    override func loadData() {
        entries = favoritesRealm.objects(Entries.self)
        collectionView.reloadData()
    }
}
