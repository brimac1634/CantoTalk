//
//  SlideUpOptionView.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 3/10/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class SlideUpOptionView: MenuBar {
    
    var optionTitles: [String] = ["Play Deck", "Add Cards to Deck", "Delete Deck"]
    let cellHeight: CGFloat = 50
    var viewHeight: CGFloat = 0
    var flashCardDeckController: FlashCardDeckController?
    
    override func setupViews() {
        collectionView.register(SlideUpOptionCells.self, forCellWithReuseIdentifier: cellID)
        collectionView.backgroundColor = UIColor.cantoWhite(a: 1)
        
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
        viewHeight = CGFloat(optionTitles.count) * cellHeight
    }
    
    //MARK: - CollectionView Methods
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        flashCardDeckController?.cardDeckOptionHandler(index: indexPath.item)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return optionTitles.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SlideUpOptionCells
        cell.label.text = optionTitles[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

class SlideUpOptionCells: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.cantoDarkBlue(a: 1) : UIColor.cantoWhite(a: 1)
            label.textColor = isHighlighted ? UIColor.cantoWhite(a: 1) : UIColor.cantoDarkBlue(a: 1)
        }
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    let divider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.cantoDarkBlue(a: 1)
        return view
    }()
    
    override func setupViews() {
        
        super.setupViews()
        
        backgroundColor = UIColor.cantoWhite(a: 1)
        
        addSubview(label)
        addSubview(divider)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            divider.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
    
    }
}
