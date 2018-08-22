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
    let pageTitles = ["Search", "Favorites", "Word of the Day", "Settings"]
    
    var lastVCIndex: Int = 0
    var titleLabel: UILabel?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupViewControllers()
        loadData()
        addView(menuIndex: 0)
        setupNavBar()
        setupLayout()
        showIconAnimation()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        

    }
    
    func showIconAnimation() {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "CantoTalkIcon"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame.size.width = view.frame.width / 2
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.layer.masksToBounds = true
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
            ])
        
        
        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
            imageView.alpha = 0
            
        }, completion: nil)
        
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
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
    }()
    
    lazy var contentView: BaseView = {
        let view = BaseView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupLayout() {
        view.backgroundColor = UIColor.cantoDarkBlue(a: 1)
        view.addSubview(menuBar)
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: 50),
            
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: menuBar.topAnchor)
            ])
        
        
        



    }
    



}






