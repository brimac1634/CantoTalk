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
 
    let defaults = UserDefaults.standard
    
    var homeController: HomeController?
    var wordOfTheDay: Results<WordOfTheDay>?
    let cellID = "cellID"
    var lastDate: Date?
    var lastDateString: String?
    var numberOfEntries: Int?
    
    let backgroundImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "WaveBackground4"))
        image.contentMode = .scaleAspectFill
//        image.alpha = 0.8
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(white: 1, alpha: 0)
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
        setupView()
        loadWordOfTheDay()
        updateData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let numberOfEntries = wordOfTheDay?.count {
            let lastItemIndex = IndexPath(item: numberOfEntries - 1, section: 0)
            collectionView.scrollToItem(at: lastItemIndex, at: .right, animated: false)
        }
        updateData()
    }
    
    private func updateData() {
        if let userRealm = homeController?.userRealm {
            wordOfTheDay = userRealm.objects(WordOfTheDay.self)
        }
        collectionView.reloadData()
    }
    
    private func loadWordOfTheDay() {

        guard let userRealm = homeController?.userRealm else {return}
        let currentDate = Date()
//        let now = Calendar.current.date(byAdding: .day, value: +3, to: Date())
//        print(now)
//        guard let currentDate = now else {return}
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.medium
        let currentDateString = dateFormatter.string(from: currentDate)
        
        lastDateString = defaults.string(forKey: "lastDateString")
        if let dateString = lastDateString {
            lastDate = dateFormatter.date(from: dateString)
        }
        
        if lastDateString == nil {
            createWordOfTheDay(date: currentDateString, userRealm: userRealm)
            lastDateString = currentDateString
            defaults.set(self.lastDateString, forKey: "lastDateString")
        } else if lastDateString == currentDateString {
            return
        } else {
            guard let pastDate = lastDate else {return}
            let dayDifference = (currentDate.interval(ofComponent: .day, fromDate: pastDate)) - 1
            print("day difference: \(dayDifference)")
            for n in (0...dayDifference).reversed() {
                guard let date = Calendar.current.date(byAdding: .day, value: -n, to: currentDate) else {return}
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = DateFormatter.Style.none
                dateFormatter.dateStyle = DateFormatter.Style.medium
                let dateString = dateFormatter.string(from: date)
                createWordOfTheDay(date: dateString, userRealm: userRealm)
            }
            lastDateString = currentDateString
            defaults.set(self.lastDateString, forKey: "lastDateString")
        }
    }

    private func setupView() {
        view.backgroundColor = UIColor.cantoWhite(a: 1)
        view.addSubview(backgroundImage)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
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


    func createWordOfTheDay(date: String, userRealm: Realm) {
        
        guard let entryList = entries else {return}
        let randomID = arc4random_uniform(UInt32(entryList.count))
        guard let newWord = entryList.filter("entryID = \(String(randomID))").first else {return}
        do {
            try userRealm.write {
                let newWOD = WordOfTheDay()
                newWOD.dateAdded = date
                newWOD.entryID = newWord.entryID
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
        if let wordOfTheDayEntry = wordOfTheDay?[indexPath.item] {
            if let entryList = entries {
                let entry = entryList.filter("entryID = \(String(wordOfTheDayEntry.entryID))").first
                cell.entryView.selectedEntry = entry
                cell.dateText.text = wordOfTheDayEntry.dateAdded
            }
            
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: collectionView.frame.height - 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 16, 0, 16)
    }

}
