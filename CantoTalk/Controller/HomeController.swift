//
//  ViewController.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 31/7/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navBar = navigationController?.navigationBar {
            navBar.barTintColor = UIColor.cantoDarkBlue(a: 1)
            navBar.isTranslucent = false
        }
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "  Home"
        titleLabel.textColor = UIColor.cantoPink(a: 1)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        setupCollectionView()
        setupNavBar()
        
    }
    
    func setupNavBar() {
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        let searchBarButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        navigationItem.rightBarButtonItem = searchBarButton
    }
    
    func setupCollectionView() {
        if let cv = collectionView {
            cv.register(WordCells.self, forCellWithReuseIdentifier: cellID)
            cv.backgroundColor = UIColor.cantoWhite(a: 1)
            cv.delegate = self
            cv.dataSource = self
        }
        
    }
    
    @objc func handleSearch() {
        //open search input
        print(123)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! WordCells
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    

}




