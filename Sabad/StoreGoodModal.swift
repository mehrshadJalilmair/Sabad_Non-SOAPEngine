//
//  StoreGoodModal.swift
//  Sabad
//
//  Created by Mehrshad JM on 3/10/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class StoreGoodModal: UIViewController {
    
    //views
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topBarView: UIView!
    
    let Image : UIImageView! = {
        
        let Image = UIImageView()
        Image.translatesAutoresizingMaskIntoConstraints = false
        return Image
    }()
    
    let offLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.backgroundColor = UIColor(r: 0, g: 200, b: 0)
        label.layer.cornerRadius = 2
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let offTitleLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.backgroundColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let offMainTimeLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.backgroundColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceContainer : UIView! = {
        
        let abuseContainer = UIView()
        abuseContainer.translatesAutoresizingMaskIntoConstraints = false
        abuseContainer.backgroundColor = UIColor.white
        return abuseContainer
    }()
    let AlPriceLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "قیمت قبلی"
        //label.backgroundColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let AlPriceNumberLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.lightGray
        label.textAlignment = .right
        //label.backgroundColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let newPriceLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "قیمت جدید"
        //label.backgroundColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let newPriceNumberLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.textAlignment = .right
        //label.backgroundColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //vars
    var good:Good!
    var haveOff = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
    }
    
    override func viewDidLayoutSubviews() {
        
        var height:CGFloat!
        
        if haveOff {
            
            height = (self.Image.frame.height + self.offTitleLabel.frame.height + self.offMainTimeLabel.frame.height + 10.0 + self.priceContainer.frame.height)
        }
        else
        {
            height = (self.Image.frame.height + self.offTitleLabel.frame.height +  10.0 + self.priceContainer.frame.height)
        }
        
        self.scrollView.contentSize = CGSize(self.view.frame.width , height)
    }
    
    func initViews()
    {
        scrollView.addSubview(Image)
        //x
        var horizontalConstraint = NSLayoutConstraint(item: Image, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //y
        var verticalConstraint = NSLayoutConstraint(item: Image, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //w
        var widthConstraint = NSLayoutConstraint(item: Image, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        var heightConstraint = NSLayoutConstraint(item: Image, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        Image.loadImageUsingCacheWithUrlString(urlString: self.good.offPrImage as! String)
        
        
        haveOff = true
        if ((good.offPercent as! Int == 0) || (good.mainTime! < 0))
        {
            haveOff = false
        }
        
        scrollView.addSubview(offLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: offLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: +20)
        //y
        verticalConstraint = NSLayoutConstraint(item: offLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: -5)
        //w
        widthConstraint = NSLayoutConstraint(item: offLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1/3, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: offLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 20)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        offLabel.text = "\(self.good.offPercent!) درصد تخفیف"
        if !haveOff
        {
            offLabel.isHidden = true
        }
        else
        {
            offLabel.isHidden = false
        }
        
        
        scrollView.addSubview(offTitleLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: offTitleLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: Image, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: offTitleLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: offTitleLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: offTitleLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 30)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        offTitleLabel.text = "\(self.good.offTitle!)"
        
        
        scrollView.addSubview(offMainTimeLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: offMainTimeLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: offTitleLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: offMainTimeLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: offMainTimeLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: offMainTimeLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 30)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        offMainTimeLabel.text = "\(self.good.mainTime!) روز دیگر"
        if !haveOff
        {
            offMainTimeLabel.isHidden = true
        }
        else
        {
            offMainTimeLabel.isHidden = false
        }
        
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(good.offBeforePrice!)")
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
        
        var newPrice = (good.offBeforePrice as! Int)
        if haveOff {
            
            newPrice = (good.offBeforePrice as! Int)  - ((good.offBeforePrice as! Int) * (good.offPercent  as! Int) / 100)
        }
        
        scrollView.addSubview(priceContainer)
        //x
        horizontalConstraint = NSLayoutConstraint(item: priceContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: offMainTimeLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        verticalConstraint = NSLayoutConstraint(item: priceContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: priceContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: priceContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 60)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        priceContainer.addSubview(AlPriceNumberLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: AlPriceNumberLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: priceContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: AlPriceNumberLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: priceContainer, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: AlPriceNumberLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: priceContainer, attribute: NSLayoutAttribute.width, multiplier: 1/2 , constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: AlPriceNumberLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: priceContainer, attribute: NSLayoutAttribute.height, multiplier: 1/2, constant: 0)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        if haveOff {
            
            AlPriceNumberLabel.attributedText = attributeString
        }
        else
        {
            //AlPriceLabel.text = "قیمت    "
            AlPriceNumberLabel.text =  "\(good.offBeforePrice!)"
        }
        
        
        priceContainer.addSubview(AlPriceLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: AlPriceLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: priceContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: AlPriceLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: AlPriceNumberLabel, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: AlPriceLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: priceContainer, attribute: NSLayoutAttribute.width, multiplier: 1/2 , constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: AlPriceLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: priceContainer, attribute: NSLayoutAttribute.height, multiplier: 1/2, constant: 0)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        priceContainer.addSubview(newPriceNumberLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: newPriceNumberLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: AlPriceNumberLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: newPriceNumberLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: priceContainer, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: newPriceNumberLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: priceContainer, attribute: NSLayoutAttribute.width, multiplier: 1/2 , constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: newPriceNumberLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: priceContainer, attribute: NSLayoutAttribute.height, multiplier: 1/2, constant: 0)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        newPriceNumberLabel.text = "\(newPrice)"
        
        priceContainer.addSubview(newPriceLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: newPriceLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: AlPriceLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: newPriceLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: newPriceNumberLabel, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: newPriceLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: priceContainer, attribute: NSLayoutAttribute.width, multiplier: 1/2 , constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: newPriceLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: priceContainer, attribute: NSLayoutAttribute.height, multiplier: 1/2, constant: 0)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        if !haveOff
        {
            newPriceNumberLabel.isHidden = true
            newPriceLabel.isHidden = true
        }
    }
}

extension StoreGoodModal
{
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
            
        }
    }
}
