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
            guard let cards = flashCardList else {return}
//            guard let window = UIApplication.shared.keyWindow else {return}
            for i in 0..<cards.count {
                flashCard = FlashCardView()
                flashCard.flashCard = cards[i]
                view.addSubview(flashCard)
                
                flashCard.flashCardCenterX = flashCard.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
                flashCard.flashCardCenterY = flashCard.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
                
                NSLayoutConstraint.activate([
                    flashCard.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
                    flashCard.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: flashCardHeightMultiplier),
                    flashCard.flashCardCenterX,
                    flashCard.flashCardCenterY,
                    ])
                
                flashCard.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
                flashCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
                
                cardArray.append(flashCard)
                currentCard = i
                topCard = cardArray[currentCard]
                view.bringSubviewToFront(checkImage)
                view.bringSubviewToFront(xImage)
            }
        }
    }

    let backgroundImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "gradientBackgroundLong")?.withRenderingMode(.alwaysOriginal))
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let checkImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "checkLarge")?.withRenderingMode(.alwaysTemplate))
        image.backgroundColor = UIColor.cantoWhite(a: 1)
        image.contentMode = .scaleAspectFit
        image.alpha = 0
        image.tintColor = UIColor.cantoDarkBlue(a: 1)
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let xImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "xLarge")?.withRenderingMode(.alwaysTemplate))
        image.backgroundColor = UIColor.cantoWhite(a: 1)
        image.contentMode = .scaleAspectFit
        image.alpha = 0
        image.tintColor = UIColor.cantoDarkBlue(a: 1)
        image.layer.cornerRadius = 22
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let checkButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "checkLarge")?.withRenderingMode(.alwaysTemplate)
        button.contentMode = .scaleAspectFit
        button.setBackgroundImage(image, for: .normal)
        button.clipsToBounds = true
        button.backgroundColor = UIColor.cantoDarkBlue(a: 1)
        button.tintColor = UIColor.cantoWhite(a: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCheck), for: .touchUpInside)
        return button
    }()
    
    let xButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "xLarge")?.withRenderingMode(.alwaysTemplate)
        button.contentMode = .scaleAspectFit
        button.setBackgroundImage(image, for: .normal)
        button.clipsToBounds = true
        button.backgroundColor = UIColor.cantoDarkBlue(a: 1)
        button.tintColor = UIColor.cantoWhite(a: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleX), for: .touchUpInside)
        return button
    }()
    
    let exitButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "exit")?.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(image, for: .normal)
        button.contentMode = .scaleAspectFit
        button.tintColor = UIColor.cantoDarkBlue(a: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleExit), for: .touchUpInside)
        return button
    }()
    
    let flashCardHeightMultiplier: CGFloat = 0.7
    var cardArray = [FlashCardView]()
    var currentCard: Int!
    var viewWidth: CGFloat!
    var checkImageWidth: CGFloat!
    var flashCard: FlashCardView!
    var topCard: FlashCardView!
    var previousCard: FlashCardView!
    var backgroundtop: NSLayoutConstraint!
    var backgroundBottom: NSLayoutConstraint!
    var checkLeading: NSLayoutConstraint!
    var checkTrailing: NSLayoutConstraint!
    var xLeading: NSLayoutConstraint!
    var xTrailing: NSLayoutConstraint!
    var changeActionPoint: CGFloat!
    var isXShowing: Bool = false
    var isCheckShowing: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        animateBackground(duration: 10)
    }
    
    func setupViews() {
        viewWidth = view.frame.width
        changeActionPoint = viewWidth / 4
        checkImageWidth = viewWidth * 0.2
        let buttonHeight: CGFloat = (view.frame.height * (1 - flashCardHeightMultiplier)) / 2 - 32
        view.backgroundColor = .clear
        checkImage.layer.cornerRadius = checkImageWidth / 2
        xImage.layer.cornerRadius = checkImageWidth / 2
        checkButton.layer.cornerRadius = buttonHeight / 2
        xButton.layer.cornerRadius = buttonHeight / 2
        
        guard let window = UIApplication.shared.keyWindow else {return}
        
        window.addSubview(backgroundImage)
        view.addSubview(checkImage)
        view.addSubview(xImage)
        view.addSubview(exitButton)
        view.addSubview(checkButton)
        view.addSubview(xButton)
        
        backgroundtop = backgroundImage.topAnchor.constraint(equalTo: window.topAnchor)
        backgroundBottom = backgroundImage.bottomAnchor.constraint(equalTo: window.bottomAnchor)
        
        checkTrailing = checkImage.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        checkLeading = checkImage.leadingAnchor.constraint(equalTo: view.trailingAnchor)
        
        xTrailing = xImage.trailingAnchor.constraint(equalTo: view.leadingAnchor)
        xLeading = xImage.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        
        NSLayoutConstraint.activate([
            backgroundBottom,
            backgroundImage.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: window.trailingAnchor),
            backgroundImage.heightAnchor.constraint(equalToConstant: 1500),
            
            exitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            exitButton.widthAnchor.constraint(equalToConstant: 40),
            exitButton.heightAnchor.constraint(equalToConstant: 40),
            
            checkImage.widthAnchor.constraint(equalToConstant: checkImageWidth),
            checkImage.heightAnchor.constraint(equalToConstant: checkImageWidth),
            checkImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            checkLeading,
            
            xImage.widthAnchor.constraint(equalToConstant: checkImageWidth),
            xImage.heightAnchor.constraint(equalToConstant: checkImageWidth),
            xImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            xTrailing,

            checkButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            checkButton.widthAnchor.constraint(equalToConstant: buttonHeight),
            checkButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            checkButton.centerXAnchor.constraint(equalTo: view.trailingAnchor, constant: -(viewWidth / 4)),

            xButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            xButton.widthAnchor.constraint(equalToConstant: buttonHeight),
            xButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            xButton.centerXAnchor.constraint(equalTo: view.leadingAnchor, constant: viewWidth / 4)
    
            ])

        window.sendSubviewToBack(backgroundImage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for card in cardArray {
            card.removeFromSuperview()
        }
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.isNavigationBarHidden = false
//        navigationController?.navigationBar.barTintColor = UIColor.cantoDarkBlue(a: 1)
//        navigationController?.navigationBar.tintColor = UIColor.cantoWhite(a: 1)
    }
    
    private func animateBackground(duration: Double) {
        guard let window = UIApplication.shared.keyWindow else {return}
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
            self.backgroundBottom.isActive = false
            self.backgroundtop.isActive = true
            window.layoutIfNeeded()
        }) { finished in
            UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
                self.backgroundBottom.isActive = true
                self.backgroundtop.isActive = false
                window.layoutIfNeeded()
            }, completion: { finished in
                self.animateBackground(duration: duration)
            })
        }
    }
    
    @objc func handleExit() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let location = gesture.translation(in: topCard)
        
        let i = location.x
        let j = location.y
        
        topCard.flashCardCenterX.constant = i
        topCard.flashCardCenterY.constant = j
        
        let rotationAngle: CGFloat = i * 0.001
        topCard.transform = CGAffineTransform(rotationAngle: rotationAngle)
        
        if i > changeActionPoint {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.switchCheckImage(showImage: true)
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            if gesture.state == .ended {
                handleCheck()
            }
            
        } else if i < -(changeActionPoint) {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.switchXImage(showImage: true)
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            if gesture.state == .ended {
                handleX()
            }
        
        } else if i > -(changeActionPoint) && i < changeActionPoint {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.switchXImage(showImage: false)
                self.switchCheckImage(showImage: false)
                self.view.layoutIfNeeded()
            }, completion: nil)
            if gesture.state == .ended {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    self.topCard.flashCardCenterX.constant = 0
                    self.topCard.flashCardCenterY.constant = 0
                    self.topCard.transform = CGAffineTransform.identity
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
            
        }
   
    }
    
    @objc func handleTap() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.topCard.flip()
        }, completion: nil)

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
    
    @objc func handleCheck() {
        previousCard = topCard
        currentCard -= 1
        if currentCard >= 0 {
            topCard = cardArray[currentCard]
        }
        
        guard let window = UIApplication.shared.keyWindow else {return}
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.previousCard.flashCardCenterX.constant = self.viewWidth * 1.5
            self.previousCard.transform = CGAffineTransform(rotationAngle: 0.244)
            self.switchCheckImage(showImage: false)
            self.view.layoutIfNeeded()
        }) { (_) in
            self.previousCard.removeFromSuperview()
        }
        
    }
    
    @objc func handleX() {
        previousCard = topCard
        currentCard -= 1
        if currentCard >= 0 {
            topCard = cardArray[currentCard]
        }
        guard let window = UIApplication.shared.keyWindow else {return}
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.previousCard.flashCardCenterX.constant = -(self.viewWidth * 1.5)
            self.previousCard.transform = CGAffineTransform(rotationAngle: -0.244)
            self.switchXImage(showImage: false)
            self.view.layoutIfNeeded()
        }) { (_) in
            self.previousCard.removeFromSuperview()
        }
    }
    
    

}
