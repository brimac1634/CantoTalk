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
    
    let userRealm = try! Realm()
    
    var flashCardDeck: FlashCardDeck? {
        didSet {
            guard let deck = flashCardDeck else {return}
            flashCardList = deck.cards
            layoutTopCard()
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
        let image = UIImage(named: "back")?.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(image, for: .normal)
        button.contentMode = .scaleAspectFit
        button.tintColor = UIColor.cantoDarkBlue(a: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleExit), for: .touchUpInside)
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "reset")?.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(image, for: .normal)
        button.contentMode = .scaleAspectFit
        button.tintColor = UIColor.cantoDarkBlue(a: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleReset), for: .touchUpInside)
        return button
    }()
    
    let endLabel: UITextView = {
        let label = UITextView()
        label.isEditable = false
        label.isSelectable = false
        label.isScrollEnabled = false
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var flashCardList: List<FlashCard>?
    var cardArray = [FlashCardView]()
    let nextCardConstant: CGFloat = 40
    var nextCardIndex: Int!
    var viewWidth: CGFloat!
    var topCardWidth: CGFloat!
    var topCardHeight: CGFloat!
    var checkImageWidth: CGFloat!
    
    var nextCard: FlashCardView!
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
    
    var deckProgress: CGFloat = 0
    var cardsCorrect: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        animateBackground(duration: 6)
    }
    
    func setupViews() {
        viewWidth = view.frame.width
        topCardWidth = viewWidth * 0.9
        topCardHeight = view.frame.height * 0.7
        changeActionPoint = viewWidth / 4
        checkImageWidth = viewWidth * 0.2
        let buttonHeight: CGFloat = (view.frame.height - topCardHeight) / 2 - 32
        view.backgroundColor = .clear
        checkImage.layer.cornerRadius = checkImageWidth / 2
        xImage.layer.cornerRadius = checkImageWidth / 2
        checkButton.layer.cornerRadius = buttonHeight / 2
        xButton.layer.cornerRadius = buttonHeight / 2
        
        guard let window = UIApplication.shared.keyWindow else {return}
        
        window.addSubview(backgroundImage)
        view.addSubview(endLabel)
        view.addSubview(checkImage)
        view.addSubview(xImage)
        view.addSubview(exitButton)
        view.addSubview(resetButton)
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
            
            endLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            endLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            endLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            endLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            exitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            exitButton.widthAnchor.constraint(equalToConstant: 34),
            exitButton.heightAnchor.constraint(equalToConstant: 34),
            
            resetButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            resetButton.widthAnchor.constraint(equalToConstant: 34),
            resetButton.heightAnchor.constraint(equalToConstant: 34),
            
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
        
        endLabel.alpha = 0
        resetButton.alpha = 0
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
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleReset() {
        UIView.animate(withDuration: 0.5) {
            self.endLabel.alpha = 0
            self.checkButton.alpha = 1
            self.xButton.alpha = 1
            self.resetButton.alpha = 0
            self.view.layoutIfNeeded()
        }
        layoutTopCard()
        
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let location = gesture.translation(in: topCard)
        nextCard.alpha = 1
        let i = location.x
        let j = location.y
        
        topCard.flashCardCenterX.constant = i
        topCard.flashCardCenterY.constant = j
        
        if nextCardIndex < cardArray.count {
            if i > 0 {
                nextCard.flashCardWidth.constant = topCardWidth - nextCardConstant + (i * nextCardConstant / (viewWidth / 2))
                nextCard.flashCardHeight.constant = topCardHeight - nextCardConstant + (i * nextCardConstant / (viewWidth / 2))
            } else {
                nextCard.flashCardWidth.constant = topCardWidth - nextCardConstant - (i * nextCardConstant / (viewWidth / 2))
                nextCard.flashCardHeight.constant = topCardHeight - nextCardConstant - (i * nextCardConstant / (viewWidth / 2))
            }
        }
        
        
        
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
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
                    self.topCard.flashCardCenterX.constant = 0
                    self.topCard.flashCardCenterY.constant = 0
                    self.topCard.transform = CGAffineTransform.identity
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
            
        }
   
    }
    
    @objc func handleTap() {
        nextCard.alpha = 1
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
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
        cardsCorrect += 1
        nextCard.alpha = 1
        if let flashCard = topCard.flashCard {
            if flashCard.cardProgress < 1 {
                try! userRealm.write {
                    flashCard.cardProgress = flashCard.cardProgress + 0.25
                    deckProgress += 0.25
                }
            }
        }
        updateProgress()
        layoutNextCard()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.topCard.flashCardWidth.constant = self.topCardWidth
            self.topCard.flashCardHeight.constant = self.topCardHeight
            self.previousCard.flashCardCenterX.constant = self.viewWidth * 1.5
            self.previousCard.transform = CGAffineTransform(rotationAngle: 0.244)
            self.switchCheckImage(showImage: false)
            self.view.layoutIfNeeded()
        }) { (_) in
            self.previousCard.removeFromSuperview()
        }
        
    }
    
    @objc func handleX() {
        nextCard.alpha = 1
        layoutNextCard()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.topCard.flashCardWidth.constant = self.topCardWidth
            self.topCard.flashCardHeight.constant = self.topCardHeight
            self.previousCard.flashCardCenterX.constant = -(self.viewWidth * 1.5)
            self.previousCard.transform = CGAffineTransform(rotationAngle: -0.244)
            self.switchXImage(showImage: false)
            self.view.layoutIfNeeded()
        }) { (_) in
            self.previousCard.removeFromSuperview()
        }
    }
    
    //MARK: - Card Layout Methods
    
    private func layoutTopCard() {
        deckProgress = 0
        cardsCorrect = 0
        cardArray = [FlashCardView]()
        guard let cards = flashCardList else {return}
        for i in 0..<cards.count {
            let flashCard = FlashCardView()
            flashCard.flashCard = cards[i]
            cardArray.append(flashCard)
        }
        topCard = cardArray[0]
        nextCardIndex = 0
        view.addSubview(topCard)
        
        topCard.flashCardCenterX = topCard.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        topCard.flashCardCenterY = topCard.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        NSLayoutConstraint.activate([
            topCard.widthAnchor.constraint(equalToConstant: topCardWidth),
            topCard.heightAnchor.constraint(equalToConstant: topCardHeight),
            topCard.flashCardCenterX,
            topCard.flashCardCenterY,
            ])
        
        topCard.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
        topCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))


        layoutNextCard()
        
        view.bringSubviewToFront(checkImage)
        view.bringSubviewToFront(xImage)
        
        for card in cards {
            deckProgress += card.cardProgress
        }
        updateProgress()
    }
        
        
    
    private func layoutNextCard() {
        previousCard = topCard
        updateEndView()
        guard nextCardIndex < cardArray.count else {return}
        topCard = cardArray[nextCardIndex]
        nextCardIndex += 1

        guard nextCardIndex < cardArray.count else {return}
        nextCard = cardArray[nextCardIndex]
        nextCard.alpha = 0
        
        
        
        view.insertSubview(nextCard, belowSubview: topCard)
        
        nextCard.flashCardWidth = nextCard.widthAnchor.constraint(equalToConstant: topCardWidth - nextCardConstant)
        nextCard.flashCardHeight = nextCard.heightAnchor.constraint(equalToConstant: topCardHeight - nextCardConstant)
        nextCard.flashCardCenterX = nextCard.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        nextCard.flashCardCenterY = nextCard.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        NSLayoutConstraint.activate([
            nextCard.flashCardWidth,
            nextCard.flashCardHeight,
            nextCard.flashCardCenterX,
            nextCard.flashCardCenterY
            ])
        
        nextCard.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
        nextCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    private func updateProgress() {
        guard let deck = flashCardDeck else {return}
        let progressPercent = deckProgress * 100 / CGFloat(deck.cards.count)
        try! userRealm.write {
            deck.progress = Int(progressPercent)
        }
    }
    
    private func updateEndView() {
        guard let deck = flashCardDeck else {return}
        guard let cards = flashCardList else {return}
        
        endLabel.text = "Congratulations!\n\nYou got \(cardsCorrect) out of \(cards.count) correct!\n\nYou have this deck \(deck.progress)% memorized."
        
        if nextCardIndex == cardArray.count {
            UIView.animate(withDuration: 0.5) {
                self.endLabel.alpha = 1
                self.checkButton.alpha = 0
                self.xButton.alpha = 0
                self.resetButton.alpha = 1
                self.view.layoutIfNeeded()
            }
        }
    }


}
