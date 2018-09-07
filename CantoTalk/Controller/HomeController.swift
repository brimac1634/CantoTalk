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

    var searchController: SearchController!
    var favoritesController: FavoritesController!
    var wordOfTheDayController: WordOfTheDayController!
    var learningKeyController: LearningKeyController!
    var cameraController: CameraController!
    
    var viewControllers: [UIViewController]!
    
    var lastVCIndex: Int = 0
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupViewControllers()
        loadData()
        addView(menuIndex: 0)
        setupNavBar()
        setupLayout()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        

    }
    
    func setupViewControllers() {
        searchController = SearchController()
        searchController.homeController = self
        favoritesController = FavoritesController()
        wordOfTheDayController = WordOfTheDayController()
        wordOfTheDayController.homeController = self
        learningKeyController = LearningKeyController()
        
        viewControllers = [searchController, favoritesController, wordOfTheDayController, learningKeyController]
    }
    
    func loadData() {
        searchController.entries = mainRealm.objects(Entries.self)
        wordOfTheDayController.entries = mainRealm.objects(Entries.self)
//        favoritesController.favoritesEntries = userRealm.objects(Favorites.self).sorted(byKeyPath: "dateFavorited", ascending: false)
    
    }
    
    private func setupNavBar() {
        
        if let navBar = navigationController?.navigationBar {
            navBar.barTintColor = UIColor.cantoDarkBlue(a: 1)
            navBar.tintColor = UIColor.cantoWhite(a: 1)
            navBar.isTranslucent = false
            navBar.shadowImage = UIImage()
            navBar.setBackgroundImage(UIImage(), for: .default)
        }
        
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "CantoTalkIconCircle"))
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        titleImageView.widthAnchor.constraint(equalToConstant: 34).isActive = true
        titleImageView.heightAnchor.constraint(equalToConstant: 34).isActive = true
        titleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = titleImageView
        
        let settingsButton = UIButton(type: .custom)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.setBackgroundImage(#imageLiteral(resourceName: "settings").withRenderingMode(.alwaysTemplate), for: .normal)
        settingsButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        settingsButton.tintColor = UIColor.cantoWhite(a: 1)
        settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: settingsButton)
        
        
        let cameraButton = UIButton(type: .custom)
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.setBackgroundImage(#imageLiteral(resourceName: "camera").withRenderingMode(.alwaysTemplate), for: .normal)
        cameraButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
        cameraButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        cameraButton.tintColor = UIColor.cantoWhite(a: 1)
        cameraButton.addTarget(self, action: #selector(handleCamera), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cameraButton)
        

    }
    
    @objc func handleSettings() {
        let settingsController = SettingsController()
        navigationController?.pushViewController(settingsController, animated: true)
    }
    
    @objc func handleCamera() {
        cameraController = CameraController()
        navigationController?.pushViewController(cameraController, animated: true)
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
        
        if menuIndex == 0 {
            searchController.hideHistoryView()
        }

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






