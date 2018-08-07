//
//  MenuBar.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 7/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.cantoDarkBlue(a: 1)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()

    let cellID = "cellID"
    let imageStrings = ["search", "heart", "calendar", "settings"]
    var homeController: HomeController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellID)
        
        addSubview(collectionView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .bottom)
        
        setupHorizontalBar()
    }
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    func setupHorizontalBar() {
        let horizontalBar = UIView()
        horizontalBar.backgroundColor = UIColor.cantoPink(a: 1)
        horizontalBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBar)
        
        horizontalBarLeftAnchorConstraint = horizontalBar.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        horizontalBar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1 / 4).isActive = true
        horizontalBar.heightAnchor.constraint(equalToConstant: 4).isActive = true
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let x = CGFloat(indexPath.item) * (frame.width / 4)
//        self.horizontalBarLeftAnchorConstraint?.constant = x
//        
//        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.layoutIfNeeded()
//        }, completion: nil)
        
        if let home = homeController {
            home.scrollToMenuIndex(menuIndex: indexPath.item)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: imageStrings[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class MenuCell: BaseCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = UIColor.cantoWhite(a: 1)
        return iv
    }()
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor.cantoPink(a: 1) : UIColor.cantoWhite(a: 1)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor.cantoPink(a: 1) : UIColor.cantoWhite(a: 1)
        }
    }

    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        
        addConstraintsWithFormat(format: "H:[v0(28)]", views: imageView)
        addConstraintsWithFormat(format: "V:[v0(28)]", views: imageView)
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
