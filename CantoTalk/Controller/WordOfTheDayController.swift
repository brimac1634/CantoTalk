//
//  WordOfTheDayController.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 2/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class WordOfTheDayController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
 
    let cellID = "cellID"
    var currentDate: Date?
    var lastDate: Date?
    var testArray: [Int]?
    
    
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.cantoDarkBlue(a: 1)
        cv.showsHorizontalScrollIndicator = false
        cv.layer.cornerRadius = 0.5
        cv.isPagingEnabled = true
        return cv
    }()

//    let topBar: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.cantoDarkBlue(a: 1)
//        return view
//    }()
//
//    let wordOfTheDayLabel: UILabel = {
//        let label = UILabel()
//        label.text = "- Word Of The Day -"
//        label.font = UIFont.boldSystemFont(ofSize: 30)
//        label.textColor = UIColor.cantoPink(a: 1)
//        label.textAlignment = NSTextAlignment.center
//        return label
//    }()
    
    override func viewDidLoad() {
        currentDate = Date()
        testArray = [0, 1, 2, 3, 4]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupCollectionView()
    }
    
    func setupCollectionView() {
        view.backgroundColor = UIColor.cantoDarkBlue(a: 1)
        view.addSubview(collectionView)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        view.addConstraintsWithFormat(format: "V:|-16-[v0]-16-|", views: collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(WordOfTheDayCells.self, forCellWithReuseIdentifier: cellID)
        collectionView.contentInset = UIEdgeInsetsMake(0, 16, 0, 0)
        if let numberOfEntries = testArray?.count {
            let lastItemIndex = IndexPath(item: numberOfEntries - 1, section: 0)
            collectionView.scrollToItem(at: lastItemIndex, at: .right, animated: false)
        }
        
        
    }


    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testArray?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

}
