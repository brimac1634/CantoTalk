//
//  WordOfTheDayController.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 2/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class WordOfTheDayController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var slideView: UIView?

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.cantoWhite(a: 1)
        cv.isPagingEnabled = true
        return cv
    }()

    let topBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.cantoDarkBlue(a: 1)
        return view
    }()

    let wordOfTheDayLabel: UILabel = {
        let label = UILabel()
        label.text = "- Word Of The Day -"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = UIColor.cantoPink(a: 1)
        label.textAlignment = NSTextAlignment.center
        return label
    }()

//    override func showEntryView(slideUpView: UIView){
//        slideView = slideUpView
//
//        slideUpView.addSubview(collectionView)
//        slideUpView.addSubview(topBar)
//        topBar.addSubview(wordOfTheDayLabel)
//
//
//
//        slideUpView.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
//        slideUpView.addConstraintsWithFormat(format: "H:|[v0]|", views: topBar)
//        slideUpView.addConstraintsWithFormat(format: "V:|[v0(40)]-8-[v1]|", views: topBar, collectionView)
//        topBar.addConstraintsWithFormat(format: "H:|[v0]|", views: wordOfTheDayLabel)
//        topBar.addConstraintsWithFormat(format: "V:|[v0]|", views: wordOfTheDayLabel)
//
//        super.showEntryView(slideUpView: slideUpView)
//        slideView?.backgroundColor = UIColor.cantoPink(a: 1)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//
//        collectionView.register(EntryView.self, forCellWithReuseIdentifier: cellID)
//
//    }

    let cellID = "cellID"

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

}
