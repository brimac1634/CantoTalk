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
 
    
    var homeController: HomeController?
    var wordOfTheDay: Results<WordOfTheDay>?
    let cellID = "cellID"
    var lastDate: Date?
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
        loadWordOfTheDay()
        setupCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let numberOfEntries = wordOfTheDay?.count {
            let lastItemIndex = IndexPath(item: numberOfEntries - 1, section: 0)
            collectionView.scrollToItem(at: lastItemIndex, at: .right, animated: false)
        }

    }
    
    func loadWordOfTheDay() {
        guard let userRealm = homeController?.userRealm else {return}
        let currentDate = Date()

        if lastDate == nil {
            createWordOfTheDay(date: currentDate, userRealm: userRealm)
        } else if lastDate == currentDate {
            return
        } else {
            guard let pastDate = lastDate else {return}
            let dayDifference = currentDate.interval(ofComponent: .day, fromDate: pastDate)
            for n in dayDifference...0 {
                guard let date = Calendar.current.date(byAdding: .day, value: -n, to: currentDate) else {return}
                print(date)
                createWordOfTheDay(date: date, userRealm: userRealm)
            }
        }
        
        wordOfTheDay = userRealm.objects(WordOfTheDay.self)
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


    func createWordOfTheDay(date: Date, userRealm: Realm) {
        
        guard let entryList = entries else {return}
        let randomID = Int(arc4random_uniform(UInt32(entryList.count)))
        guard let newWord = entryList.filter("entryID = \(randomID)").first else {return}
        
        do {
            try userRealm.write {
                let newWOD = WordOfTheDay()
                newWOD.dateAdded = date
                newWOD.entryID = newWord.entryID
                newWOD.cantoWord = newWord.cantoWord
                newWOD.classifier = newWord.classifier
                newWOD.jyutping = newWord.jyutping
                newWOD.wordType = newWord.wordType
                newWOD.englishWord = newWord.englishWord
                newWOD.mandarinWord = newWord.mandarinWord
                newWOD.cantoSentence = newWord.cantoSentence
                newWOD.jyutpingSentence = newWord.jyutpingSentence
                newWOD.englishSentence = newWord.englishSentence
                userRealm.add(newWOD)
            }
        } catch {
            print(error)
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wordOfTheDay?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! WordOfTheDayCells
        if let entry = entries?[indexPath.item] {
            cell.entryView.selectedEntry = entry
        }
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
