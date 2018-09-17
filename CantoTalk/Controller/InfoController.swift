//
//  InfoController.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 17/9/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class InfoController: UIViewController {

    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = 2000
        view.backgroundColor = UIColor.cantoWhite(a: 1)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }


    func setupView() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }

}
