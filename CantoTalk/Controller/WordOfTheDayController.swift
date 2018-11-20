//
//  WordOfTheDayController.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 2/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit
import RealmSwift

class WordOfTheDayController: HorizontalPeekingPagesCollectionViewController {
 
    let defaults = UserDefaults.standard
    
    let backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backgroundImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "gradientBackgroundLong")?.withRenderingMode(.alwaysOriginal))
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let userRealm = try! Realm()
    var homeController: HomeController?
    var wordOfTheDay: Results<WordOfTheDay>?
    let cellID = "cellID"
    var lastDate: Date?
    var lastDateString: String?
    var numberOfEntries: Int?
    var currentOffset: CGFloat = 0
    
    var backgroundtop: NSLayoutConstraint!
    var backgroundBottom: NSLayoutConstraint!

    var entries: Results<Entries>? {
        didSet {
            if let entry = entries {
                numberOfEntries = entry.count
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadWordOfTheDay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let numberOfEntries = wordOfTheDay?.count {
            let lastItemIndex = IndexPath(item: numberOfEntries - 1, section: 0)
            collectionView.scrollToItem(at: lastItemIndex, at: .right, animated: false)
        }
        animateBackground(duration: 6)
    }
    
    private func updateData() {
        wordOfTheDay = userRealm.objects(WordOfTheDay.self)
        dataSourceCount = wordOfTheDay?.count ?? 0
        collectionView.reloadData()
    }
    
    private func setupView() {
        view.backgroundColor = .clear
        
        view.addSubview(backView)
        backView.addSubview(backgroundImage)
        
        backgroundtop = backgroundImage.topAnchor.constraint(equalTo: backView.topAnchor, constant: -200)
        backgroundBottom = backgroundImage.bottomAnchor.constraint(equalTo: backView.bottomAnchor)
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: view.topAnchor),
            backView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backgroundBottom,
            backgroundImage.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
            backgroundImage.heightAnchor.constraint(equalToConstant: 1500),
            ])
        
        collectionView.register(WordOfTheDayCells.self, forCellWithReuseIdentifier: cellID)
    }
    
    //MARK: - Word of the day methods
    
    func loadWordOfTheDay() {

        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.medium
        let currentDateString = dateFormatter.string(from: currentDate)
        
        
        lastDateString = defaults.string(forKey: "lastDateString")
        if let date = defaults.object(forKey: "lastDate") {
            lastDate = (date as! Date)
        }
        
        if lastDateString == nil {
            createWordOfTheDay(date: currentDateString, userRealm: userRealm)
            lastDateString = currentDateString
            lastDate = currentDate
            defaults.set(self.lastDateString, forKey: "lastDateString")
            defaults.set(self.lastDate, forKey: "lastDate")
        } else if lastDateString == currentDateString {
            return
        } else {
            guard let pastDate = lastDate else {return}
            let dayDifference = (currentDate.interval(ofComponent: .day, fromDate: pastDate)) - 1
            print("day difference: \(dayDifference)")
            guard dayDifference >= 0 else {return}
            for n in (0...dayDifference).reversed() {
                guard let date = Calendar.current.date(byAdding: .day, value: -n, to: currentDate) else {return}
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = DateFormatter.Style.none
                dateFormatter.dateStyle = DateFormatter.Style.medium
                let dateString = dateFormatter.string(from: date)
                createWordOfTheDay(date: dateString, userRealm: userRealm)
            }
            lastDateString = currentDateString
            lastDate = currentDate
            defaults.set(self.lastDateString, forKey: "lastDateString")
            defaults.set(self.lastDate, forKey: "lastDate")
        }
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
    
    //MARK: - CollectionView Methods
    
    override func calculateSectionInset() -> CGFloat {
        return 16
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wordOfTheDay?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    
    
    //MARK: - Animation Method
    
    private func animateBackground(duration: Double) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
            self.backgroundBottom.isActive = false
            self.backgroundtop.isActive = true
            self.backView.layoutIfNeeded()
        }) { finished in
            UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
                self.backgroundBottom.isActive = true
                self.backgroundtop.isActive = false
                self.backView.layoutIfNeeded()
            }, completion: { finished in
                self.animateBackground(duration: duration)
            })
        }
    }
    
}
