//
//  ViewController.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 31/7/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit
import RealmSwift

class HomeController: UIViewController {

    let mainRealm = try! Realm(configuration: Realm.Configuration(fileURL: Bundle.main.url(forResource: "default", withExtension: "realm"), readOnly: true))
    let favoritesRealm = try! Realm()

    var searchController: SearchController!
    var favoritesController: FavoritesController!
    var wordOfTheDayController: WordOfTheDayController!
    var settingsController: SettingsController!
    
    var viewControllers: [UIViewController]!
    let vcTitles = ["Search", "Favorites", "Word of the Day", "Settings"]
    
    var lastVCIndex: Int = 0
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupViewControllers()
        loadData()
        addView(menuIndex: 0)
        setupNavBar()
        setupMenuBar()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showIconAnimation()

    }

//    func loadFavorites() {
//        entries = favoritesRealm.objects(Entries.self).sorted(byKeyPath: "dateFavorited", ascending: false)
//        collectionView?.reloadData()
//    }
    
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
    
    func setupViewControllers() {
        searchController = SearchController()
        searchController.homeController = self
        favoritesController = FavoritesController()
        wordOfTheDayController = WordOfTheDayController()
        settingsController = SettingsController()
        
        viewControllers = [searchController, favoritesController, wordOfTheDayController, settingsController]
    }
    
    func loadData() {
        searchController.entries = mainRealm.objects(Entries.self)
        favoritesController.favoritesEntries = favoritesRealm.objects(Entries.self).sorted(byKeyPath: "dateFavorited", ascending: false)
    }
    
//    func setupSearchBar() {
//
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "English/Cantonese/Mandarin/Jyutping"
//        searchController.searchBar.sizeThatFits(CGSize(width: view.frame.width - 50, height: view.frame.height))
//        searchController.searchBar.tintColor = UIColor.cantoPink(a: 1)
//        searchController.hidesNavigationBarDuringPresentation = false
//
//        let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField
//        if let backgroundView = textField?.subviews.first {
//            backgroundView.backgroundColor = UIColor.cantoWhite(a: 1)
//            backgroundView.layer.cornerRadius = 10
//            backgroundView.clipsToBounds = true
//        }
//
//        navigationItem.searchController = searchController
//        definesPresentationContext = true
//    }

    
    func setupNavBar() {
        
        if let navBar = navigationController?.navigationBar {
            navBar.barTintColor = UIColor.cantoDarkBlue(a: 1)
            navBar.isTranslucent = false
            navBar.tintColor = UIColor.cantoPink(a: 1)
        }
        
        let titleLabel = UILabel(frame: CGRect(x: view.frame.width / 2, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "CantoTalk"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.cantoPink(a: 1)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        
        
    }
    
    
    
    func addView(menuIndex: Int) {
        if lastVCIndex != menuIndex {
            let previousVC = viewControllers[lastVCIndex]
            previousVC.willMove(toParentViewController: nil)
            previousVC.view.removeFromSuperview()
            previousVC.removeFromParentViewController()
        }
        
        let selectedVC = viewControllers[menuIndex]

        
        
        addChildViewController(selectedVC)
        selectedVC.view.frame = contentView.bounds
        contentView.addSubview(selectedVC.view)
        selectedVC.didMove(toParentViewController: self)
        
        lastVCIndex = menuIndex
        
        func prepare(for: UIStoryboardSegue, sender: Any?) {
            let backButton = UIBarButtonItem()
            backButton.title = vcTitles[menuIndex]
            navigationItem.backBarButtonItem = backButton
        }

    }
    

    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    lazy var contentView: BaseView = {
        let view = BaseView()
        return view
    }()
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addSubview(contentView)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: contentView)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0][v1(50)]|", views: contentView, menuBar)
    }
    



}






