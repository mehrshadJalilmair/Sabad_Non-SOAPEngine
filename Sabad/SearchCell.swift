//
//  SearchCell.swift
//  Sabad
//
//  Created by Mehrshad Jalilmasir on 1/27/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    
    /*let IImageView: UIImageView = {
        let IImageView = UIImageView()
        IImageView.translatesAutoresizingMaskIntoConstraints = false
        IImageView.layer.cornerRadius = 24
        IImageView.layer.masksToBounds = true
        IImageView.contentMode = .scaleAspectFill
        return IImageView
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        //        label.text = "HH:MM:SS"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()*/
    let View : UIView! = {
        
        let View = UIView()
        //View.backgroundColor = UIColor.green
        View.translatesAutoresizingMaskIntoConstraints = false
        //View.layer.cornerRadius = 3
        //View.layer.masksToBounds = true
        return View
    }()
    
    let cimage: UIImageView! = {
        
        let cimage = UIImageView()
        cimage.translatesAutoresizingMaskIntoConstraints = false
        cimage.contentMode = .scaleToFill
        return cimage
    }()
    
    let nameLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.textAlignment = .right
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tellLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.textAlignment = .right
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.textAlignment = .right
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        /*addSubview(IImageView)
        addSubview(timeLabel)
        //ios 9 constraint anchors
        //need x,y,width,height anchors
        IImageView.leftAnchor.constraint(equalTo:self.leftAnchor, constant: 8).isActive = true
        IImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        IImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        IImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        //need x,y,width,height anchors
        timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 18).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: (textLabel?.heightAnchor)!).isActive = true*/
        
        contentView.addSubview(View)
        View.backgroundColor = UIColor.white
        View.layer.cornerRadius = 3.0
        View.layer.masksToBounds = false
        View.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
        View.layer.shadowOffset = CGSize(width: 0, height: 0)
        View.layer.shadowOpacity = 0.4
        //x
        var horizontalConstraint = NSLayoutConstraint(item: View, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //y
        var verticalConstraint = NSLayoutConstraint(item: View, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        //w
        var widthConstraint = NSLayoutConstraint(item: View, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -8)
        //h
        var heightConstraint = NSLayoutConstraint(item: View, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.height, multiplier: 1, constant: -8)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        View.addSubview(cimage)
        //x
        horizontalConstraint = NSLayoutConstraint(item: cimage, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: View, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: cimage, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: View, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: cimage, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: View, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: cimage, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: View, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        

        View.addSubview(nameLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: View, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: View, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: cimage, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: View, attribute: NSLayoutAttribute.height, multiplier: 1/3, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        View.addSubview(tellLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: tellLabel, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: View, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: tellLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: nameLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: tellLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: cimage, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: tellLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: View, attribute: NSLayoutAttribute.height, multiplier: 1/3, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        View.addSubview(addLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: addLabel, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: View, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: addLabel, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: View, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: addLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: cimage, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: addLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: View, attribute: NSLayoutAttribute.height, multiplier: 1/3, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        //contentView.backgroundColor = UIColor.lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
