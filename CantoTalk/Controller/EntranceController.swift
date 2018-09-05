//
//  EntranceController.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 5/9/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class EntranceController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cantoWhite(a: 1)
        let animation = LoadingAnimation()
        animation.loadAnimation(view: view, diameter: 175)
        let navController = UINavigationController(rootViewController: HomeController())
        navController.modalTransitionStyle = .coverVertical
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            self.present(navController, animated: true, completion: nil)
        }
        
        
    }


}
