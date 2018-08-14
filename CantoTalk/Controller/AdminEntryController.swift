//
//  AdminEntryControllerViewController.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 14/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class AdminEntryController: UIViewController {
    
    let adminEntry: AdminEntry = {
        let entry = AdminEntry()
        entry.backgroundColor = UIColor.cantoLightBlue(a: 1)
        return entry
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red

        view.addSubview(adminEntry)
        
       
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: adminEntry)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: adminEntry)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
