//
//  UserCell.swift
//  gameofchats
//
//  Created by Brian Voong on 7/8/16.
//  Copyright © 2016 letsbuildthatapp. All rights reserved.
//

import UIKit

class GoodCell: UICollectionViewCell {
    
    let image: UIImageView! = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let mainTimeLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.red
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let alreadyPriceLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let newPriceLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let offLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.red
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var topRightView : UIView! = {
        
        let topRightView = UIView()
        topRightView.translatesAutoresizingMaskIntoConstraints = false
        topRightView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        return topRightView
    }()
    let iconInTopRightView: UIImageView! = {
        
        let iconInTopRightView = UIImageView()
        iconInTopRightView.translatesAutoresizingMaskIntoConstraints = false
        iconInTopRightView.contentMode = .scaleToFill
        //iconInTopRightView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        return iconInTopRightView
    }()
    let labelInTopRightView: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        //label.backgroundColor = UIColor.lightGray
        //label.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var textLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.4).cgColor
        //contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        //contentView.layer.shadowOpacity = 1
        contentView.layer.cornerRadius = 0.2
        contentView.layer.masksToBounds = true
        
        //let cellWidth = ((SCREEN_SIZE.width) / 2) - 10
        //let cellHeight = ((SCREEN_SIZE.width) / 2) + cellWidth/2 - 15
        
        contentView.addSubview(image)
        //x
        var horizontalConstraint = NSLayoutConstraint(item: image, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //y
        var verticalConstraint = NSLayoutConstraint(item: image, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //w
        var widthConstraint = NSLayoutConstraint(item: image, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        var heightConstraint = NSLayoutConstraint(item: image, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: contentView.frame.size.width)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        contentView.addSubview(mainTimeLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: mainTimeLabel, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: image, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: mainTimeLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: mainTimeLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: mainTimeLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 15)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
     
        
        let labelsHeight = (contentView.frame.size.height - contentView.frame.size.width) / 3
        
        contentView.addSubview(titleLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: image, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: -2)
        //w
        widthConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: labelsHeight)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        contentView.addSubview(alreadyPriceLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: alreadyPriceLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: titleLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: alreadyPriceLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: -2)
        //w
        widthConstraint = NSLayoutConstraint(item: alreadyPriceLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: alreadyPriceLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: labelsHeight)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        contentView.addSubview(newPriceLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: newPriceLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: alreadyPriceLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: newPriceLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: -2)
        //w
        widthConstraint = NSLayoutConstraint(item: newPriceLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: newPriceLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: labelsHeight)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        contentView.addSubview(offLabel)
        offLabel.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_4));
        //x
        horizontalConstraint = NSLayoutConstraint(item: offLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: -12)
        //y
        verticalConstraint = NSLayoutConstraint(item: offLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: -8)
        //w
        widthConstraint = NSLayoutConstraint(item: offLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 60)
        //h
        heightConstraint = NSLayoutConstraint(item: offLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 40)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        
        contentView.addSubview(topRightView)
        //x
        horizontalConstraint = NSLayoutConstraint(item: topRightView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 5)
        //y
        verticalConstraint = NSLayoutConstraint(item: topRightView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -5)
        //w
        widthConstraint = NSLayoutConstraint(item: topRightView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: contentView.frame.width/2)
        //h
        heightConstraint = NSLayoutConstraint(item: topRightView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 20)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        topRightView.addSubview(iconInTopRightView)
        //x
        horizontalConstraint = NSLayoutConstraint(item: iconInTopRightView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: topRightView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: iconInTopRightView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: topRightView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: iconInTopRightView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: topRightView, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: iconInTopRightView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: topRightView, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        topRightView.addSubview(labelInTopRightView)
        //x
        horizontalConstraint = NSLayoutConstraint(item: labelInTopRightView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: topRightView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: labelInTopRightView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: iconInTopRightView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: labelInTopRightView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: topRightView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: labelInTopRightView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: topRightView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: +5)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
