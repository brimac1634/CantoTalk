//
//  ViewController.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 31/7/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class HomeController: UIViewController {

    let mainRealm = try! Realm(configuration: Realm.Configuration(fileURL: Bundle.main.url(forResource: "default", withExtension: "realm"), readOnly: true))

    var searchController: SearchController!
    var favoritesController: FavoritesController!
    var wordOfTheDayController: WordOfTheDayController!
    var flashCardDeckController: FlashCardDeckController!
    var cameraController: CameraController!
    var infoController: InfoController!
    
    var viewControllers: [UIViewController]!
    
    var lastVCIndex: Int = 0
    var notificationTime = DateComponents()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    var openMenuIndex: Int = 0
 
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
        let openMenuIndex = appDelegate.openMenuIndex
        setupNotification()
        menuBar.selectView(index: openMenuIndex)
        menuBar.animateViewChange(index: openMenuIndex)
    }
    
    func setupViewControllers() {
        searchController = SearchController()
        searchController.homeController = self
        favoritesController = FavoritesController()
        wordOfTheDayController = WordOfTheDayController()
        wordOfTheDayController.homeController = self
        flashCardDeckController = FlashCardDeckController()
        
        viewControllers = [searchController, favoritesController, wordOfTheDayController, flashCardDeckController]
    }
    
    func loadData() {
        searchController.entries = mainRealm.objects(Entries.self)
        wordOfTheDayController.entries = mainRealm.objects(Entries.self)
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
        settingsButton.navBarButtonSetup(image: #imageLiteral(resourceName: "settings"))
        settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        
        let infoButton = UIButton(type: .custom)
        infoButton.navBarButtonSetup(image: #imageLiteral(resourceName: "info"))
        infoButton.addTarget(self, action: #selector(handleInfo), for: .touchUpInside)
        
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: settingsButton), UIBarButtonItem(customView: infoButton)]
        
        
        let cameraButton = UIButton(type: .custom)
        cameraButton.navBarButtonSetup(image: #imageLiteral(resourceName: "camera"))
        cameraButton.addTarget(self, action: #selector(handleCamera), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cameraButton)
        

    }
    
    func setupNotification() {
        let content = UNMutableNotificationContent()
        content.title = "CantoTalk Word of the Day"
        content.body = "You have a new word of the day!"
        content.sound = UNNotificationSound.default
        
        
        notificationTime.hour = 9
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 6, repeats: false)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: true)
        let request = UNNotificationRequest(identifier: "WordOfTheDayController", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    
    //MARK:- Action Handlers
    
    @objc func handleSettings() {
        let settingsController = SettingsController()
        navigationController?.pushViewController(settingsController, animated: true)
    }
    
    @objc func handleInfo() {
        let infoController = InfoController()
        navigationController?.pushViewController(infoController, animated: true)
    }
    
    @objc func handleCamera() {
        cameraController = CameraController()
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(cameraController, animated: true)
    }
    func addView(menuIndex: Int = 0) {
        if lastVCIndex != menuIndex {
            let previousVC = viewControllers[lastVCIndex]
            previousVC.willMove(toParent: nil)
            previousVC.view.removeFromSuperview()
            previousVC.removeFromParent()
        }
        
        let selectedVC = viewControllers[menuIndex]

        addChild(selectedVC)
        selectedVC.view.frame = contentView.bounds
        contentView.addSubview(selectedVC.view)
        selectedVC.didMove(toParent: self)
        
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
        
        view.sendSubviewToBack(contentView)
    }

}






