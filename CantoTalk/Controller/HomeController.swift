//
//  ViewController.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 31/7/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    let cellID = "cellID"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setupNavBar()
        setupCollectionView()
        setupSearchBar()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let window = UIApplication.shared.keyWindow {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "CantoTalkIcon")
            let imageDiameter = (window.frame.width / 2)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.frame = CGRect(x: 0, y: 0, width: imageDiameter, height: imageDiameter)
            imageView.center.x = window.frame.width / 2
            imageView.center.y = (window.frame.height / 2) - (imageDiameter / 2)
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = imageView.frame.size.width / 2
            imageView.layer.masksToBounds = true
            
            view.addSubview(imageView)
        
            UIView.animate(withDuration: 1.5, delay: 0.5, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
                imageView.alpha = 0
    
            }, completion: nil)
        }
        
        
        

    }
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    func setupSearchBar() {
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "English/Cantonese/Jyutping"
        searchController.searchBar.sizeToFit()
        searchController.searchBar.tintColor = UIColor.cantoPink(a: 1)
        
        let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField
        if let backgroundView = textField?.subviews.first {
            backgroundView.backgroundColor = UIColor.cantoWhite(a: 1)
            backgroundView.layer.cornerRadius = 10
            backgroundView.clipsToBounds = true
        }
        
        
        
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func setupNavBar() {
        
        if let navBar = navigationController?.navigationBar {
            navBar.barTintColor = UIColor.cantoDarkBlue(a: 1)
            navBar.isTranslucent = false
            navBar.tintColor = UIColor.cantoPink(a: 1)
        }
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "  CantoTalk"
        titleLabel.textColor = UIColor.cantoPink(a: 1)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        
//        let searchField = UISearchBar(frame: CGRect(x: view.frame.width / 2, y: 0, width: view.frame.width - 32 - 32, height: view.frame.height))
//        searchField.placeholder = "English/Cantonese/Jyutping"
//        searchField.isTranslucent = false
//        searchField.sizeToFit()
//        searchField.backgroundImage = UIImage()
//        searchField.delegate = self
//        navigationItem.titleView = searchField
        
        
        let heartImage = UIImage(named: "heart")?.withRenderingMode(.alwaysTemplate)
        let favoritesBarButton = UIBarButtonItem(image: heartImage, style: .plain, target: self, action: #selector(handleFavorites))
        
        let wordOfTheDayImage = UIImage(named: "check_calendar")?.withRenderingMode(.alwaysTemplate)
        let wordOfTheDayButton = UIBarButtonItem(image: wordOfTheDayImage, style: .plain, target: self, action: #selector(handleWordOfTheDay))
        
        navigationItem.rightBarButtonItems = [wordOfTheDayButton, favoritesBarButton]
        
    }
    
    func setupCollectionView() {
        if let cv = collectionView {
            cv.register(WordCells.self, forCellWithReuseIdentifier: cellID)
            cv.backgroundColor = UIColor.cantoWhite(a: 1)
            cv.delegate = self
            cv.dataSource = self
        }
        
    }
    
    @objc func handleFavorites() {
        //open search input
        print(123)
    }
    
    @objc func handleWordOfTheDay() {
        //show word of day view
        print(456)
    }
    
    let entryViewController = EntryViewController()
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        entryViewController.showEntryView()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! WordCells
        //set labels based on entries array
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    

}






