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

    let mainRealm = try! Realm(configuration: Realm.Configuration(fileURL: Bundle.main.url(forResource: "default", withExtension: "realm"), readOnly: false))
    let favoritesRealm = try! Realm()
    


    var searchController: SearchController!
    var favoritesController: FavoritesController!
    var wordOfTheDayController: WordOfTheDayController!
    var settingsController: SettingsController!
    
    var viewControllers: [UIViewController]!
    let pageTitles = ["Search", "Favorites", "Word of the Day", "Settings"]
    
    var lastVCIndex: Int = 0
    var titleLabel: UILabel?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupViewControllers()
        loadData()
        addView(menuIndex: 0)
        setupNavBar()
        setupMenuBar()
        showIconAnimation()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        

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
            
            UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
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
    
    func setupNavBar() {
        
        if let navBar = navigationController?.navigationBar {
            navBar.barTintColor = UIColor.cantoDarkBlue(a: 1)
            navBar.isTranslucent = false
            navBar.tintColor = UIColor.cantoPink(a: 1)
        }
        
        titleLabel = UILabel(frame: CGRect(x: view.frame.width / 2, y: 0, width: view.frame.width - 32, height: view.frame.height))
        if let title = titleLabel {
            title.text = "Search"
            title.textAlignment = .center
            title.textColor = UIColor.cantoPink(a: 1)
            title.font = UIFont.boldSystemFont(ofSize: 20)
            navigationItem.titleView = title
        }
   
        
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
        
        titleLabel?.text = pageTitles[menuIndex]
        
        lastVCIndex = menuIndex

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






