//
//  WordOfTheDayController.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 2/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit
import RealmSwift

class WordOfTheDayController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
 
    let cellID = "cellID"
    var lastDate: Date?
    var wordOfTheDayArray: [Int]?
    var numberOfEntries: Int?

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.cantoWhite(a: 1)
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()

    var entries: Results<Entries>? {
        didSet {
            if let entry = entries {
                numberOfEntries = entry.count
            }
            
        }
    }
    
    override func viewDidLoad() {
        let currentDate = Date()

        if let entryList = entries {
            if lastDate == currentDate {
                return
            } else {
                if let pastDate = lastDate {
                    let dayDifference = currentDate.interval(ofComponent: .day, fromDate: pastDate)
                    for n in 0...dayDifference - 1 {
                        let randomID = Int(arc4random_uniform(UInt32(entryList.count)))
                        let wordOfTheDay = entryList.filter("entryID = \(randomID)").first
                        print(wordOfTheDay)
                        
                    }
                    
                }
                
            }
        }
        
        wordOfTheDayArray = [0, 1, 2, 3, 4]
        
        setupCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let numberOfEntries = wordOfTheDayArray?.count {
            let lastItemIndex = IndexPath(item: numberOfEntries - 1, section: 0)
            collectionView.scrollToItem(at: lastItemIndex, at: .right, animated: false)
        }

    }

    func setupCollectionView() {
        view.backgroundColor = UIColor.cantoWhite(a: 1)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
            ])
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(WordOfTheDayCells.self, forCellWithReuseIdentifier: cellID)
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 8)
    }


    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wordOfTheDayArray?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 16, height: collectionView.frame.height - 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 8, 0, 8)
    }

}
