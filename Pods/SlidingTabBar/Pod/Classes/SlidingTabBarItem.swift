//
//  SlidingTabBarItem.swift
//  
//
//  Created by Adam Bardon on 25/02/16.
//  Copyright © 2016 Adam Bardon. All rights reserved.
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php


import UIKit

public class SlidingTabBarItem: UIView {
    
    public var iconView: UIImageView!
    public var textLabel: UILabel!
    
    public init (frame : CGRect, tintColor: UIColor, item: UITabBarItem) {
        super.init(frame : frame)
        
        guard let image = item.image else {
            fatalError("SlidingTabBar: add images to tabbar items")
        }
        
        // create imageView centered within a container
        iconView = UIImageView(frame: CGRect(x: (self.frame.width-image.size.width)/2, y: (self.frame.height-image.size.height)/2 - 10, width: self.frame.width, height: self.frame.height))
        iconView.image = image.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        iconView.tintColor = tintColor
        iconView.sizeToFit()
        
        var TLX:CGFloat = frame.size.width/2 - 15
        if(item.title == "خانه")
        {
            TLX = frame.size.width/2 - 10
        }
        
        textLabel = UILabel(frame: CGRect(x: TLX , y: (self.frame.height-image.size.height)/2 , width: self.frame.width, height: self.frame.height))
        textLabel.text = item.title
        textLabel.font = UIFont(name: "American Typewriter" , size: 14)
        //textLabel.textAlignment = .left
        textLabel.textColor = tintColor
        
        self.addSubview(textLabel)
        self.addSubview(iconView)
    }
    
    public convenience init () {
        self.init(frame:CGRect.zero,tintColor:UIColor.white,item:UITabBarItem())
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
