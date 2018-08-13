//
//  SettingsController.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 9/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class SettingsController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.cantoLightBlue(a: 1)
        tv.separatorStyle = .none
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    
    
    let cellID = "cellID"
    let cellImageNames: [String] = ["unlock", "trending", "request", "notification", "admin"]
    let cellTitles: [String] = ["Upgrades", "Trends", "Request Words", "Notifications", "Admin"]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }


    func setupViews() {
        view.backgroundColor = UIColor.cantoLightBlue(a: 1)
        let diameter = view.frame.width / 2
        
        let logoView: UIImageView = {
            let logo = UIImageView()
            logo.image = UIImage(named: "CantoTalkIcon")
            logo.frame.size = CGSize(width: diameter, height: diameter)
            logo.contentMode = .scaleAspectFill
            logo.layer.cornerRadius = diameter / 2
            logo.layer.masksToBounds = true
            return logo
        }()
        
        
        view.addSubview(logoView)
        view.addSubview(tableView)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: tableView)
        view.addConstraintsWithFormat(format: "H:[v0(\(diameter))]", views: logoView)
        view.addConstraintsWithFormat(format: "V:|-16-[v0(\(diameter))]-16-[v1]|", views: logoView, tableView)
        
        view.addConstraint(NSLayoutConstraint(item: logoView, attribute: .centerX, relatedBy: .equal, toItem: tableView, attribute: .centerX, multiplier: 1, constant: 0))
        
        tableView.register(SettingCell.self, forCellReuseIdentifier: cellID)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SettingCell
        cell.cellImage.image = UIImage(named: cellImageNames[indexPath.row])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.cantoDarkBlue(a: 1)
        cell.cellTitleLabel.text = cellTitles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    

}

class SettingCell: UITableViewCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.cantoDarkBlue(a: 1) : UIColor.cantoWhite(a: 1)
            cellTitleLabel.textColor = isHighlighted ? UIColor.cantoPink(a: 1) : UIColor.cantoDarkBlue(a: 1)
            cellImage.tintColor = isHighlighted ? UIColor.cantoPink(a: 1) : UIColor.cantoDarkBlue(a: 1)
        }
    }
    
    let cellImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    let cellTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    
    func setupViews() {
        addSubview(cellImage)
        addSubview(cellTitleLabel)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]-8-|", views: cellImage, cellTitleLabel)
        addConstraintsWithFormat(format: "V:[v0(30)]", views: cellImage)
        addConstraintsWithFormat(format: "V:|[v0]|", views: cellTitleLabel)
        
        addConstraint(NSLayoutConstraint(item: cellImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}








