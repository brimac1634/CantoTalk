//
//  FlashCardSwipController.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 4/10/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit
import RealmSwift

class FlashCardSwipeController: UIViewController {
    
    var flashCardList: List<FlashCard>? {
        didSet {
            //do something
        }
    }
    
    let flashCard: FlashCardView = {
        let card = FlashCardView()
        return card
    }()
    
    var flashCardCenterX: NSLayoutConstraint!
    var flashCardCenterY: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()

    }
    
    func setupViews() {
        view.backgroundColor = UIColor.cantoWhite(a: 1)
        
        flashCardCenterX = flashCard.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        flashCardCenterY = flashCard.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        
        view.addSubview(flashCard)
        
        NSLayoutConstraint.activate([
            flashCard.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            flashCard.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            flashCardCenterX,
            flashCardCenterY
            ])
        
        flashCard.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor.cantoDarkBlue(a: 1)
        navigationController?.navigationBar.tintColor = UIColor.cantoWhite(a: 1)
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let location = gesture.translation(in: view)
        print(location)
    }


}
