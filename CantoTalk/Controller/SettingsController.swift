//
//  SettingsController.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 9/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let imageName: String
    let name: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

class SettingsController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let logoDiameter: CGFloat = 200
    
    
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.cantoLightBlue(a: 1)
        tv.separatorStyle = .none
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    
    
    let cellID = "cellID"
    let settings: [Setting] = {
        return [Setting(name: "Request Words", imageName: "request"), Setting(name: "Notifications", imageName: "notification"), Setting(name: "Rate Us", imageName: "rate_us")]
    }()
    var vcs: [UIViewController]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }


    func setupViews() {
        view.backgroundColor = UIColor.cantoLightBlue(a: 1)
        

        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
            ])

        
        tableView.register(SettingCell.self, forCellReuseIdentifier: cellID)
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //do something
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SettingCell
        let settings = self.settings[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.settings = settings
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    

}










