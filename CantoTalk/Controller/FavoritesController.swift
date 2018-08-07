//
//  FavoritesControllerCollectionViewController.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 7/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

//import UIKit
//import RealmSwift
//
//private let reuseIdentifier = "Cell"
//
//class FavoritesController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
//
//    let cellID = "cellID"
//    let favoriteEntries: Results<Entries>?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        self.collectionView!.register(WordCells.self, forCellWithReuseIdentifier: cellID)
//
//    }
//
//    
//
//    // MARK: UICollectionViewDataSource
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let entries = favoriteEntries {
//            return entries.count
//        }
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
//        return cell
//    }
//}
