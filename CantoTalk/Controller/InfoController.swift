//
//  InfoController.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 17/9/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class InfoController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let allKeys = PronounciationKeyBank()
    let keySections: [[PronounciationKey]] = PronounciationKeyBank.init().keys
    let cellID = "cellID"
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.cantoWhite(a: 1)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cantoWhite(a: 1)
        setupView()
    }


    func setupView() {
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        tableView.register(KeyCell.self, forCellReuseIdentifier: cellID)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return keySections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return allKeys.keyHeaders[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keySections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! KeyCell
        cell.pronounciationKey = allKeys.keys[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    
    

    

}
