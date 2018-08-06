//
//  ViewController.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 31/7/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit
import RealmSwift

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
        showIconAnimation()

    }
    
    func showIconAnimation() {
        if let window = UIApplication.shared.keyWindow {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "CantoTalkIcon")
            let imageDiameter = (window.frame.width / 2)
            imageView.frame.size = CGSize(width: imageDiameter, height: imageDiameter)
            imageView.center.x = window.frame.width / 2
            imageView.center.y = (window.frame.height / 2) - (imageDiameter / 2)
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = imageView.frame.size.width / 2
            imageView.layer.masksToBounds = true
            
            view.addSubview(imageView)
            
            UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
                imageView.alpha = 0
                
            }, completion: nil)
        }
    }
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    func setupSearchBar() {
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "English/Cantonese/Jyutping"
        searchController.searchBar.sizeThatFits(CGSize(width: view.frame.width - 50, height: view.frame.height))
        searchController.searchBar.tintColor = UIColor.cantoPink(a: 1)
        searchController.hidesNavigationBarDuringPresentation = false
        
        let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField
        if let backgroundView = textField?.subviews.first {
            backgroundView.backgroundColor = UIColor.cantoWhite(a: 1)
            backgroundView.layer.cornerRadius = 10
            backgroundView.clipsToBounds = true
        }
        
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    @objc func dismissKeyboard() {
        searchController.searchBar.endEditing(true)
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
        
        
//        let menuImage = UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate)
//        let menuButton = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(handleMenu))
        
        
        let heartImage = UIImage(named: "heart_folder")?.withRenderingMode(.alwaysTemplate)
        let favoritesBarButton = UIBarButtonItem(image: heartImage, style: .plain, target: self, action: #selector(handleFavorites))
        
        let wordOfTheDayImage = UIImage(named: "check_calendar")?.withRenderingMode(.alwaysTemplate)
        let wordOfTheDayButton = UIBarButtonItem(image: wordOfTheDayImage, style: .plain, target: self, action: #selector(handleWordOfTheDay))
        

        navigationItem.rightBarButtonItems = [wordOfTheDayButton, favoritesBarButton]
        
    }
    
    @objc func handleMenu() {
        print(789)
    }
    
    @objc func handleFavorites() {
        //open search input
        print(123)
    }
    
    @objc func handleWordOfTheDay() {
        let view = UIView()
        wordOfTheDayController.showEntryView(slideUpView: view)
    }
    
    //MARK: - CollectionView Methods
    
    func setupCollectionView() {
        if let cv = collectionView {
            cv.register(WordCells.self, forCellWithReuseIdentifier: cellID)
            cv.backgroundColor = UIColor.cantoWhite(a: 1)
            cv.delegate = self
            cv.dataSource = self
        }
        
    }
    

    
    let slideUpViewController = SlideUpViewController()
    let wordOfTheDayController = WordOfTheDayController()
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let view = EntryView()
        slideUpViewController.showEntryView(slideUpView: view)
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






