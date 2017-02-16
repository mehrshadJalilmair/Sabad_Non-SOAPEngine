//
//  GoodModal.swift
//  Sabad
//
//  Created by Mehrshad JM on 2/10/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class GoodModal: UIViewController {

    //views
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var fav_icon: UIButton!
    
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
    
    lazy var storeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("رفتن به فروشگاه", for: .normal)
        //button.setImage(UIImage(named: "ic_refresh"), for: .normal)
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 2
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        //button.semanticContentAttribute = .forceRightToLeft
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(gotoStore), for: .touchUpInside)
        return button
    }()
    
    let containersContainer : UIView! = {
        
        let containersContainer = UIView()
        containersContainer.backgroundColor = UIColor.green
        containersContainer.translatesAutoresizingMaskIntoConstraints = false
        return containersContainer
    }()
    let visitsCountContainer : UIView! = {
        
        let visitsCountContainer = UIView()
        visitsCountContainer.translatesAutoresizingMaskIntoConstraints = false
        visitsCountContainer.backgroundColor = UIColor.white
        return visitsCountContainer
    }()
    let visitLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.backgroundColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var visitIcon:UIButton! = {
        
        let followerIcon = UIButton(type: .system)
        followerIcon.setImage(UIImage(named :"ic_refresh"), for: UIControlState.normal)
        //followerIcon.addTarget(self, action: #selector(setAbusesetAbuse), for: UIControlEvents.touchUpInside)
        followerIcon.translatesAutoresizingMaskIntoConstraints = false
        followerIcon.backgroundColor = UIColor.lightGray
        followerIcon.isUserInteractionEnabled = false
        return followerIcon
    }()
    
    let abuseContainer : UIView! = {
        
        let abuseContainer = UIView()
        abuseContainer.translatesAutoresizingMaskIntoConstraints = false
        abuseContainer.backgroundColor = UIColor.white
        return abuseContainer
    }()
    lazy var abuseLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.text = "ثبت تخلف"
        label.backgroundColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setAbuse)))
        return label
    }()
    lazy var setAbuseButton:UIButton! = {
        
        let icon = UIButton(type: .system)
        icon.setImage(UIImage(named :"errorImage"), for: UIControlState.normal)
        icon.addTarget(self, action: #selector(setAbuse), for: UIControlEvents.touchUpInside)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.backgroundColor = UIColor.lightGray
        return icon
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
        setInits()
    }
    
    override func viewDidLayoutSubviews() {
        
        var height:CGFloat!
        
        if haveOff {
            
            height = (self.Image.frame.height + self.offTitleLabel.frame.height + self.offMainTimeLabel.frame.height + self.containersContainer.frame.height + self.storeButton.frame.height + 10 + self.priceContainer.frame.height)
        }
        else
        {
            height = (self.Image.frame.height + self.offTitleLabel.frame.height + self.containersContainer.frame.height + self.storeButton.frame.height + 10 + self.priceContainer.frame.height)
        }
        
        self.scrollView.contentSize = CGSize(self.view.frame.width , height)
    }
    
    func setInits()
    {
        if defaults.object(forKey: "offId\(self.good.Id!)") == nil
        {
            fav_icon.setImage(UIImage(named: "favorite_unset"), for: UIControlState.normal)
        }
        else
        {
            fav_icon.setImage(UIImage(named: "favorite_set"), for: UIControlState.normal)
        }
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
        
        
        let tempViews:[UIView] = [offTitleLabel , offMainTimeLabel]
        haveOff = true
        var tempIndex = 1
        if ((good.offPercent as! Int == 0) || (good.mainTime! < 0))
        {
            haveOff = false
            tempIndex = 0
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
        
        
        scrollView.addSubview(storeButton)
        //x
        horizontalConstraint = NSLayoutConstraint(item: storeButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: tempViews[tempIndex], attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        verticalConstraint = NSLayoutConstraint(item: storeButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: storeButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -20)
        //h
        heightConstraint = NSLayoutConstraint(item: storeButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 30)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        
        scrollView.addSubview(containersContainer)
        //x
        horizontalConstraint = NSLayoutConstraint(item: containersContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: storeButton, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        verticalConstraint = NSLayoutConstraint(item: containersContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: containersContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: containersContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 30)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        
        containersContainer.addSubview(visitsCountContainer)
        //x
        horizontalConstraint = NSLayoutConstraint(item: visitsCountContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: containersContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: visitsCountContainer, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: containersContainer, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: visitsCountContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: containersContainer, attribute: NSLayoutAttribute.width, multiplier: 1/2, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: visitsCountContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: containersContainer, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        
        containersContainer.addSubview(abuseContainer)
        //x
        horizontalConstraint = NSLayoutConstraint(item: abuseContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: containersContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: abuseContainer, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: visitsCountContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: +1)
        //w
        widthConstraint = NSLayoutConstraint(item: abuseContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: containersContainer, attribute: NSLayoutAttribute.width, multiplier: 1/2, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: abuseContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: containersContainer, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        
        visitsCountContainer.addSubview(visitLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: visitLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: visitsCountContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: visitLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: visitsCountContainer, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: visitLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: visitsCountContainer, attribute: NSLayoutAttribute.width, multiplier: 1 , constant: -30)
        //h
        heightConstraint = NSLayoutConstraint(item: visitLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: visitsCountContainer, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        visitLabel.text = "\(self.good.Views!) بازدید"
        
        
        visitsCountContainer.addSubview(visitIcon)
        //x
        horizontalConstraint = NSLayoutConstraint(item: visitIcon, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: visitLabel, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: visitIcon, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: visitLabel, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: visitIcon, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: visitsCountContainer, attribute: NSLayoutAttribute.height, multiplier: 1 , constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: visitIcon, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: visitsCountContainer, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        
        
        abuseContainer.addSubview(abuseLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: abuseLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: abuseContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: abuseLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: abuseContainer, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: abuseLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: abuseContainer, attribute: NSLayoutAttribute.width, multiplier: 1 , constant: -30)
        //h
        heightConstraint = NSLayoutConstraint(item: abuseLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: abuseContainer, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        
        
        abuseContainer.addSubview(setAbuseButton)
        //x
        horizontalConstraint = NSLayoutConstraint(item: setAbuseButton, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: abuseLabel, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: setAbuseButton, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: abuseLabel, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: setAbuseButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: abuseContainer, attribute: NSLayoutAttribute.height, multiplier: 1 , constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: setAbuseButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: abuseContainer, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(good.offBeforePrice!)")
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
        
        var newPrice = (good.offBeforePrice as! Int)
        if haveOff {
            
            newPrice = (good.offBeforePrice as! Int)  - ((good.offBeforePrice as! Int) * (good.offPercent  as! Int) / 100)
        }
        
        scrollView.addSubview(priceContainer)
        //x
        horizontalConstraint = NSLayoutConstraint(item: priceContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: containersContainer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
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
        AlPriceNumberLabel.attributedText = attributeString
        
    
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
    }
}

extension GoodModal
{
    @IBAction func favorite(_ sender: Any) {
        
        if defaults.object(forKey: "offId\(self.good.Id!)") == nil
        {
            fav_icon.setImage(UIImage(named: "favorite_set"), for: UIControlState.normal)
            defaults.set(self.good.Id, forKey: "offId\(self.good.Id!)")
            defaults.set(self.good.offActive, forKey: "offActive\(self.good.Id!)")
            defaults.set(self.good.offBeforePrice, forKey: "offBeforePrice\(self.good.Id!)")
            defaults.set(self.good.offDescription, forKey: "offDescription\(self.good.Id!)")
            defaults.set(self.good.offEndDate, forKey: "offEndDate\(self.good.Id!)")
            defaults.set(self.good.offEndTime, forKey: "offEndTime\(self.good.Id!)")
            defaults.set(self.good.offPercent, forKey: "offPercent\(self.good.Id!)")
            defaults.set(self.good.offPrImage, forKey: "offPrImage\(self.good.Id!)")
            defaults.set(self.good.mainTime, forKey: "mainTime\(self.good.Id!)")
            defaults.set(self.good.Views, forKey: "Views\(self.good.Id!)")
            defaults.set(self.good.servicesId, forKey: "servicesId\(self.good.Id!)")
            defaults.set(self.good.offTitle, forKey: "offTitle\(self.good.Id!)")
            defaults.set(self.good.offStartTime, forKey: "offStartTime\(self.good.Id!)")
            defaults.set(self.good.offEndTime, forKey: "offEndTime\(self.good.Id!)")
        }
        else
        {
            fav_icon.setImage(UIImage(named: "favorite_unset"), for: UIControlState.normal)
            defaults.removeObject(forKey: "offId\(self.good.Id!)")
            defaults.removeObject(forKey: "offActive\(self.good.Id!)")
            defaults.removeObject(forKey: "offBeforePrice\(self.good.Id!)")
            defaults.removeObject(forKey: "offDescription\(self.good.Id!)")
            defaults.removeObject(forKey: "offEndDate\(self.good.Id!)")
            defaults.removeObject(forKey: "offEndTime\(self.good.Id!)")
            defaults.removeObject(forKey: "offPercent\(self.good.Id!)")
            defaults.removeObject(forKey: "offPrImage\(self.good.Id!)")
            defaults.removeObject(forKey: "mainTime\(self.good.Id!)")
            defaults.removeObject(forKey: "Views\(self.good.Id!)")
            defaults.removeObject(forKey: "servicesId\(self.good.Id!)")
            defaults.removeObject(forKey: "offTitle\(self.good.Id!)")
            defaults.removeObject(forKey: "offStartTime\(self.good.Id!)")
            defaults.removeObject(forKey: "offEndTime\(self.good.Id!)")
        }
    }
    
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true) { 
            
            
        }
    }
    
    @IBAction func showAddress(_ sender: Any) {
        
        
        let soap = SOAPEngine()
        soap.userAgent = "SOAPEngine"
        soap.actionNamespaceSlash = true
        soap.version = SOAPVersion.VERSION_1_1
        soap.responseHeader = true
        
        soap.setValue(self.good.Id as! Int, forKey: "offId")
        soap.requestURL(Request.webServiceAddress,
                        soapAction: Request.getGoodAddressAction,
                        completeWithDictionary: { (statusCode : Int,
                            dict : [AnyHashable : Any]?) -> Void in
                            
                            let result:Dictionary = dict! as Dictionary
                            //print(result)
                            let result1:NSDictionary = result[Array(result.keys)[0]]! as! NSDictionary
                            let result2:NSDictionary = result1["AddressOfGoodResponse"] as! NSDictionary
                            var result3:String = result2["AddressOfGoodResult"] as! String
                            
                            result3 = "{ \"content\" : " + result3 + "}"
                            //print(result3)
                            let data = (result3).data(using: .utf8)!
                            
                            guard let _result = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : AnyObject] else{
                                
                                return
                            }
                            
                            if let _ads = _result["content"] as? [AnyObject]{
                                
                                for ad in _ads
                                {
                                    
                                    if let actad = ad as? [String : AnyObject]{
                                        
                                        
                                        let popup = PopupController
                                            .create(self)
                                            .customize(
                                                [
                                                    .layout(.top),
                                                    .animation(.slideDown),
                                                    .scrollable(false),
                                                    .dismissWhenTaps(false),
                                                    .backgroundStyle(.blackFilter(alpha: 0))
                                                ]
                                            )
                                            .didShowHandler { popup in
                                                print("showed popup!")
                                                
                                            }
                                            .didCloseHandler { _ in
                                                
                                                print("closed popup!")
                                        }
                                        //print(actad)
                                        let container = GoodAddress.instance()
                                        container.address = "\n\(actad["MallName"]!)\n\(actad["stName"]!)\n\(actad["stAddress"]!)\n\(actad["stTel"]!)"
                                        
                                        container.closeHandler = { _ in
                                            popup.dismiss()
                                        }
                                        popup.show(container)
                                        
                                        return
                                    }
                                }
                            }
                            
        }) { (error : Error?) -> Void in
            
            print(error!)
        }
    }
    
    func gotoStore()
    {
        let soap = SOAPEngine()
        soap.userAgent = "SOAPEngine"
        soap.actionNamespaceSlash = true
        soap.version = SOAPVersion.VERSION_1_1
        soap.responseHeader = true
        
        soap.setValue(self.good.Id as! Int, forKey: "offId")
        soap.requestURL(Request.webServiceAddress,
                        soapAction: Request.gotoStoreAction,
                        completeWithDictionary: { (statusCode : Int,
                            dict : [AnyHashable : Any]?) -> Void in
                            
                            let result:Dictionary = dict! as Dictionary
                            //print(result)
                            let result1:NSDictionary = result[Array(result.keys)[0]]! as! NSDictionary
                            let result2:NSDictionary = result1["StoreOfGoodResponse"] as! NSDictionary
                            var result3:String = result2["StoreOfGoodResult"] as! String
                            
                            result3 = "{ \"content\" : " + result3 + "}"
                            print(result3)
                            let data = (result3).data(using: .utf8)!
                            
                            guard let _result = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : AnyObject] else{
                                
                                return
                            }
                            
                            if let _stores = _result["content"] as? [AnyObject]{
                                
                                for store in _stores
                                {
                                    
                                    if let actstore = store as? [String : AnyObject]{
                                        
                                        let newstore = Store(Id: actstore["Id"]!, stCode: actstore["stCode"]!, MallId: actstore["MallId"]!, stName: actstore["stName"]!, stAddress: actstore["stAddress"]!, stManager: actstore["stManager"]!, stDescription: actstore["stDescription"]!, stTel: actstore["stTel"]!, stActive: actstore["stActive"]!, Mobile: actstore["Mobile"]!, urlImage: actstore["urlImage"]!, pm: actstore["pm"]!, Followers: actstore["Followers"]!)
                                        
                                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                        let mvc = storyboard.instantiateViewController(withIdentifier: "StoreModal") as! StoreModal
                                        mvc.isModalInPopover = true
                                        mvc.modalTransitionStyle = .coverVertical
                                        mvc.store = newstore
                                        self.present(mvc, animated: true, completion: nil)
                                        
                                        return
                                    }
                                }
                            }
        }) { (error : Error?) -> Void in
            
            print(error!)
        }
    }
    
    func setAbuse()
    {
        abuseGood = self.good
        abuseType = 1
        let popup = PopupController
            .create(self)
            .customize(
                [
                    .layout(.center),
                    .animation(.fadeIn),
                    .backgroundStyle(.blackFilter(alpha: 0.8)),
                    .dismissWhenTaps(true),
                    .scrollable(true)
                ]
            )
            .didShowHandler { popup in
                print("showed popup!")
            }
            .didCloseHandler { popup in
                
        }
        
        let container = setAbuseController.instance()
        container.closeHandler = { _ in
            popup.dismiss()
        }
        popup.show(container)
    }
}
