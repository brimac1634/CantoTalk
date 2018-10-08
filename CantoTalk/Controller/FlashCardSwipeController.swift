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

    var viewWidth: CGFloat!

    
    let flashCard: FlashCardView = {
        let card = FlashCardView()
        return card
    }()
    
    let checkImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "checkLarge")?.withRenderingMode(.alwaysTemplate))
        image.contentMode = .scaleAspectFit
        image.alpha = 0
        image.tintColor = UIColor.cantoDarkBlue(a: 1)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let xImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "xLarge")?.withRenderingMode(.alwaysTemplate))
        image.contentMode = .scaleAspectFit
        image.alpha = 0
        image.tintColor = UIColor.cantoDarkBlue(a: 1)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var flashCardCenterX: NSLayoutConstraint!
    var flashCardCenterY: NSLayoutConstraint!
    var checkLeading: NSLayoutConstraint!
    var checkTrailing: NSLayoutConstraint!
    var xLeading: NSLayoutConstraint!
    var xTrailing: NSLayoutConstraint!
    var changeActionPoint: CGFloat!
    var isXShowing: Bool = false
    var isCheckShowing: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        viewWidth = view.frame.width
        changeActionPoint = viewWidth / 4
        setupViews()
        loadData()

    }
    
    func setupViews() {
        view.backgroundColor = UIColor.cantoWhite(a: 1)
        
        guard let window = UIApplication.shared.keyWindow else {return}
        window.addSubview(flashCard)
        window.addSubview(checkImage)
        window.addSubview(xImage)
        
        flashCardCenterX = flashCard.centerXAnchor.constraint(equalTo: window.centerXAnchor, constant: 0)
        flashCardCenterY = flashCard.centerYAnchor.constraint(equalTo: window.centerYAnchor, constant: 0)
        
        checkTrailing = checkImage.trailingAnchor.constraint(equalTo: window.trailingAnchor)
        checkLeading = checkImage.leadingAnchor.constraint(equalTo: window.trailingAnchor)
        
        xTrailing = xImage.trailingAnchor.constraint(equalTo: window.leadingAnchor)
        xLeading = xImage.leadingAnchor.constraint(equalTo: window.leadingAnchor)
        
        NSLayoutConstraint.activate([
            flashCard.widthAnchor.constraint(equalTo: window.widthAnchor, multiplier: 0.9),
            flashCard.heightAnchor.constraint(equalTo: window.heightAnchor, multiplier: 0.7),
            flashCardCenterX,
            flashCardCenterY,
            
            checkImage.widthAnchor.constraint(equalTo: window.widthAnchor, multiplier: 0.2),
            checkImage.heightAnchor.constraint(equalTo: checkImage.widthAnchor),
            checkImage.centerYAnchor.constraint(equalTo: window.centerYAnchor),
            checkLeading,
            
            xImage.widthAnchor.constraint(equalTo: window.widthAnchor, multiplier: 0.2),
            xImage.heightAnchor.constraint(equalTo: xImage.widthAnchor),
            xImage.centerYAnchor.constraint(equalTo: window.centerYAnchor),
            xTrailing
            ])
        
        flashCard.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        flashCard.removeFromSuperview()
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.navigationBar.barTintColor = UIColor.cantoDarkBlue(a: 1)
        navigationController?.navigationBar.tintColor = UIColor.cantoWhite(a: 1)
    }
    
    private func loadData() {
        
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        guard let window = UIApplication.shared.keyWindow else {return}
        let location = gesture.translation(in: view)
        
        let i = location.x
        let j = location.y
        print(i)
        
        flashCardCenterX.constant = i
        flashCardCenterY.constant = j
        
        let rotationAngle: CGFloat = i * 0.001
        flashCard.transform = CGAffineTransform(rotationAngle: rotationAngle)
        
        if i > changeActionPoint {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.switchCheckImage(showImage: true)
                window.layoutIfNeeded()
            }, completion: nil)
            
            if gesture.state == .ended {
                print("I know this word")
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    self.flashCardCenterX.constant = self.viewWidth * 2
                    self.switchCheckImage(showImage: false)
                    window.layoutIfNeeded()
                }, completion: nil)
            }
            
        } else if i < -(changeActionPoint) {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.switchXImage(showImage: true)
                window.layoutIfNeeded()
            }, completion: nil)
            
            if gesture.state == .ended {
                print("I don't know this word")
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    self.flashCardCenterX.constant = -(self.viewWidth * 2)
                    self.switchXImage(showImage: false)
                    window.layoutIfNeeded()
                }, completion: nil)
            }
        
        } else if i > -(changeActionPoint) && i < changeActionPoint {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.switchXImage(showImage: false)
                self.switchCheckImage(showImage: false)
                window.layoutIfNeeded()
            }, completion: nil)
            if gesture.state == .ended {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    self.flashCardCenterX.constant = 0
                    self.flashCardCenterY.constant = 0
                    self.flashCard.transform = CGAffineTransform.identity
                    window.layoutIfNeeded()
                }, completion: nil)
            }
            
        }
   
    }
    
    private func switchXImage(showImage: Bool) {
        isXShowing = showImage
        xTrailing.isActive = isXShowing ? false : true
        xLeading.isActive = isXShowing ? true : false
        xImage.alpha = isXShowing ? 1 : 0
    }
    
    private func switchCheckImage(showImage: Bool) {
        isCheckShowing = showImage
        checkTrailing.isActive = isCheckShowing ? true : false
        checkLeading.isActive = isCheckShowing ? false : true
        checkImage.alpha = isCheckShowing ? 1 : 0
    }


}
