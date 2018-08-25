//
//  SettingsCell.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 14/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.cantoDarkBlue(a: 1) : UIColor.cantoWhite(a: 1)
            cellTitleLabel.textColor = isHighlighted ? UIColor.cantoPink(a: 1) : UIColor.cantoDarkBlue(a: 1)
            cellImage.tintColor = isHighlighted ? UIColor.cantoPink(a: 1) : UIColor.cantoDarkBlue(a: 1)
        }
    }
    
    var settings: Setting? {
        didSet {
            cellTitleLabel.text = settings?.name
            if let image = settings?.imageName {
                cellImage.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
                cellImage.tintColor = UIColor.cantoDarkBlue(a: 1)
            }
            
        }
    }
    
    let cellImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "notification")?.withRenderingMode(.alwaysTemplate)
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let cellTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    
    func setupViews() {
        addSubview(cellImage)
        addSubview(cellTitleLabel)
        
        NSLayoutConstraint.activate([
            cellImage.widthAnchor.constraint(equalToConstant: 30),
            cellImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            cellImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            cellTitleLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 16),
            cellTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            cellTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
