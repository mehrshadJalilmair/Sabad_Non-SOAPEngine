//
//  StoreCreation.swift
//  Sabad
//
//  Created by Mehrshad JM on 2/20/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class StoreCreation: UIViewController , UIScrollViewDelegate{

    @IBOutlet var scrollView: UIScrollView!
    
    
    
    let ImagesContainer : UIView! = {
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        filterView.backgroundColor = UIColor.red
        return filterView
    }()
    lazy var logo: UIImageView! = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named:"nedstark")
        imageView.tag = 0
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pickLogo(_:))))
        return imageView
    }()
    lazy var image1: UIImageView! = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named:"nedstark")
        imageView.tag = 1
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pickImage1(_:))))
        return imageView
    }()
    lazy var image2: UIImageView! = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named:"nedstark")
        imageView.isUserInteractionEnabled = true
        imageView.tag = 2
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pickImage2(_:))))
        return imageView
    }()
    lazy var image3: UIImageView! = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named:"nedstark")
        imageView.isUserInteractionEnabled = true
        imageView.tag = 3
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pickImage3(_:))))
        return imageView
    }()
    let logoLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.white
        label.text = "لوگو"
        label.textAlignment = .center
        label.backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var delLogoImageBtn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        //button.setTitle("پیگیری", for: .normal)
        button.setImage(UIImage(named: "ic_delete_forever_white"), for: .normal)
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        //button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        //button.semanticContentAttribute = .forceRightToLeft
        button.showsTouchWhenHighlighted = true
        button.tag = 0
        button.addTarget(self, action: #selector(delImage(_:)), for: .touchUpInside)
        return button
    }()
    lazy var delImage3Btn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        //button.setTitle("پیگیری", for: .normal)
        button.setImage(UIImage(named: "ic_delete_forever_white"), for: .normal)
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        //button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        //button.semanticContentAttribute = .forceRightToLeft
        button.showsTouchWhenHighlighted = true
        button.tag = 3
        button.addTarget(self, action: #selector(delImage(_:)), for: .touchUpInside)
        return button
    }()
    lazy var delImage2Btn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        //button.setTitle("پیگیری", for: .normal)
        button.setImage(UIImage(named: "ic_delete_forever_white"), for: .normal)
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        //button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        //button.semanticContentAttribute = .forceRightToLeft
        button.showsTouchWhenHighlighted = true
        button.tag = 2
        button.addTarget(self, action: #selector(delImage(_:)), for: .touchUpInside)
        return button
    }()
    lazy var delImage1Btn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        //button.setTitle("پیگیری", for: .normal)
        button.setImage(UIImage(named: "ic_delete_forever_white"), for: .normal)
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        //button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        //button.semanticContentAttribute = .forceRightToLeft
        button.showsTouchWhenHighlighted = true
        button.tag = 1
        button.addTarget(self, action: #selector(delImage(_:)), for: .touchUpInside)
        return button
    }()
    
    
    
    let NameContainer : UIView! = {
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        filterView.backgroundColor = UIColor.red
        return filterView
    }()
    let NameLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.text = "نام فروشگاه"
        label.textAlignment = .right
        label.backgroundColor = UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let NameTextFieald: FloatLabelTextField! = {
        
        let NameTextFieald = FloatLabelTextField()
        NameTextFieald.font = UIFont.systemFont(ofSize: 14)
        NameTextFieald.textColor = UIColor.black
        NameTextFieald.textAlignment = .center
        NameTextFieald.placeholder = "نام فروشگاه"
        NameTextFieald.textAlignment = .center
        NameTextFieald.backgroundColor = UIColor.white
        NameTextFieald.tintColor = UIColor.red
        NameTextFieald.translatesAutoresizingMaskIntoConstraints = false
        return NameTextFieald
    }()
    
    
    
    
    let ManagementContainer : UIView! = {
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        filterView.backgroundColor = UIColor.red
        return filterView
    }()
    
    let PhoneContainer : UIView! = {
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        filterView.backgroundColor = UIColor.red
        return filterView
    }()
    
    let DescriptionContainer : UIView! = {
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        filterView.backgroundColor = UIColor.red
        return filterView
    }()
    
    let AddressContainer : UIView! = {
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        filterView.backgroundColor = UIColor.red
        return filterView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        openGettingStoreFields = false
        initImagesContainer()
        initNameContainer()
        initManagementContainer()
        initPhoneContainer()
        initDescriptionContainer()
        initAddressContainer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        setScrollViewContentSize()
    }
    
    override func viewDidLayoutSubviews() {
        
        delLogoImageBtn.layer.cornerRadius = delLogoImageBtn.frame.size.width/2
        delLogoImageBtn.clipsToBounds = true
        delImage2Btn.layer.cornerRadius = delLogoImageBtn.frame.size.width/2
        delImage2Btn.clipsToBounds = true
        delImage3Btn.layer.cornerRadius = delLogoImageBtn.frame.size.width/2
        delImage3Btn.clipsToBounds = true
        delImage1Btn.layer.cornerRadius = delLogoImageBtn.frame.size.width/2
        delImage1Btn.clipsToBounds = true
    }
    
    func setScrollViewContentSize() {
        
        var height: CGFloat
        
        let lastViewYPos = self.AddressContainer.frame.origin.y  // this is absolute positioning, not relative
        let lastViewHeight = self.AddressContainer.frame.size.height
        
        height = lastViewYPos + lastViewHeight + 5
    
        scrollView.contentSize.height = height
        
        scrollView.isUserInteractionEnabled = true
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    func initImagesContainer()
    {
        //let width = ((SCREEN_SIZE.width) / 2) - 10
        let height = ((SCREEN_SIZE.width) / 4)
        
        scrollView.addSubview(ImagesContainer)
        //x
        var horizontalConstraint = NSLayoutConstraint(item: ImagesContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //y
        var verticalConstraint = NSLayoutConstraint(item: ImagesContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: +5)
        //w
        var widthConstraint = NSLayoutConstraint(item: ImagesContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -10)
        //h
        var heightConstraint = NSLayoutConstraint(item: ImagesContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: height)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        ImagesContainer.addSubview(logo)
        //x
        horizontalConstraint = NSLayoutConstraint(item: logo, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: ImagesContainer, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: logo, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: ImagesContainer, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: +5.5)
        //w
        widthConstraint = NSLayoutConstraint(item: logo, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: ImagesContainer, attribute: NSLayoutAttribute.width, multiplier: 1/4, constant: -5)
        //h
        heightConstraint = NSLayoutConstraint(item: logo, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: height - 5)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        ImagesContainer.addSubview(logoLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: logoLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: logo, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: logoLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: logo, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: logoLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: logo, attribute: NSLayoutAttribute.width, multiplier: 1/2, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: logoLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 20)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        ImagesContainer.addSubview(delLogoImageBtn)
        //x
        horizontalConstraint = NSLayoutConstraint(item: delLogoImageBtn, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: logo, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 2)
        //y
        verticalConstraint = NSLayoutConstraint(item: delLogoImageBtn, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: logo, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 2)
        //w
        widthConstraint = NSLayoutConstraint(item: delLogoImageBtn, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: logo, attribute: NSLayoutAttribute.width, multiplier: 1/3, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: delLogoImageBtn, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: logo, attribute: NSLayoutAttribute.width, multiplier: 1/3, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        ImagesContainer.addSubview(image1)
        //x
        horizontalConstraint = NSLayoutConstraint(item: image1, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: ImagesContainer, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: image1, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: logo, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: +3)
        //w
        widthConstraint = NSLayoutConstraint(item: image1, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: ImagesContainer, attribute: NSLayoutAttribute.width, multiplier: 1/4, constant: -5)
        //h
        heightConstraint = NSLayoutConstraint(item: image1, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: height - 5)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        ImagesContainer.addSubview(delImage1Btn)
        //x
        horizontalConstraint = NSLayoutConstraint(item: delImage1Btn, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: image1, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 2)
        //y
        verticalConstraint = NSLayoutConstraint(item: delImage1Btn, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: image1, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 2)
        //w
        widthConstraint = NSLayoutConstraint(item: delImage1Btn, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: image1, attribute: NSLayoutAttribute.width, multiplier: 1/3, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: delImage1Btn, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: image1, attribute: NSLayoutAttribute.width, multiplier: 1/3, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        ImagesContainer.addSubview(image2)
        //x
        horizontalConstraint = NSLayoutConstraint(item: image2, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: ImagesContainer, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: image2, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: image1, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: +3)
        //w
        widthConstraint = NSLayoutConstraint(item: image2, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: ImagesContainer, attribute: NSLayoutAttribute.width, multiplier: 1/4, constant: -5)
        //h
        heightConstraint = NSLayoutConstraint(item: image2, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: height - 5)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        ImagesContainer.addSubview(delImage2Btn)
        //x
        horizontalConstraint = NSLayoutConstraint(item: delImage2Btn, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: image2, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 2)
        //y
        verticalConstraint = NSLayoutConstraint(item: delImage2Btn, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: image2, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 2)
        //w
        widthConstraint = NSLayoutConstraint(item: delImage2Btn, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: image2, attribute: NSLayoutAttribute.width, multiplier: 1/3, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: delImage2Btn, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: image2, attribute: NSLayoutAttribute.width, multiplier: 1/3, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        
        ImagesContainer.addSubview(image3)
        //x
        horizontalConstraint = NSLayoutConstraint(item: image3, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: ImagesContainer, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: image3, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: image2, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: +3)
        //w
        widthConstraint = NSLayoutConstraint(item: image3, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: ImagesContainer, attribute: NSLayoutAttribute.width, multiplier: 1/4, constant: -5)
        //h
        heightConstraint = NSLayoutConstraint(item: image3, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: height - 5)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        ImagesContainer.addSubview(delImage3Btn)
        //x
        horizontalConstraint = NSLayoutConstraint(item: delImage3Btn, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: image3, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: +2)
        //y
        verticalConstraint = NSLayoutConstraint(item: delImage3Btn, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: image3, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 2)
        //w
        widthConstraint = NSLayoutConstraint(item: delImage3Btn, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: image2, attribute: NSLayoutAttribute.width, multiplier: 1/3, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: delImage3Btn, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: image3, attribute: NSLayoutAttribute.width, multiplier: 1/3, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func initNameContainer()
    {
        scrollView.addSubview(NameContainer)
        //x
        var horizontalConstraint = NSLayoutConstraint(item: NameContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: ImagesContainer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        var verticalConstraint = NSLayoutConstraint(item: NameContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        var widthConstraint = NSLayoutConstraint(item: NameContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -10)
        //h
        var heightConstraint = NSLayoutConstraint(item: NameContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.height, multiplier: 1/6, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        NameContainer.addSubview(NameLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: NameLabel, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: NameContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: NameLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: NameContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: NameLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: NameContainer, attribute: NSLayoutAttribute.width, multiplier: 1/2, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: NameLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: NameContainer, attribute: NSLayoutAttribute.height, multiplier: 2/3, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        NameContainer.addSubview(NameTextFieald)
        //x
        horizontalConstraint = NSLayoutConstraint(item: NameTextFieald, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: NameContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: NameTextFieald, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: NameLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: NameTextFieald, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: NameContainer, attribute: NSLayoutAttribute.width, multiplier: 3/4, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: NameTextFieald, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: NameContainer, attribute: NSLayoutAttribute.height, multiplier: 1/3, constant: -5)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func initManagementContainer()
    {
        scrollView.addSubview(ManagementContainer)
        //x
        let horizontalConstraint = NSLayoutConstraint(item: ManagementContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: NameContainer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        let verticalConstraint = NSLayoutConstraint(item: ManagementContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        let widthConstraint = NSLayoutConstraint(item: ManagementContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -10)
        //h
        let heightConstraint = NSLayoutConstraint(item: ManagementContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.height, multiplier: 1/6, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func initPhoneContainer()
    {
        scrollView.addSubview(PhoneContainer)
        //x
        let horizontalConstraint = NSLayoutConstraint(item: PhoneContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: ManagementContainer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        let verticalConstraint = NSLayoutConstraint(item: PhoneContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        let widthConstraint = NSLayoutConstraint(item: PhoneContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -10)
        //h
        let heightConstraint = NSLayoutConstraint(item: PhoneContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.height, multiplier: 1/6, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func initDescriptionContainer()
    {
        scrollView.addSubview(DescriptionContainer)
        //x
        let horizontalConstraint = NSLayoutConstraint(item: DescriptionContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: PhoneContainer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        let verticalConstraint = NSLayoutConstraint(item: DescriptionContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        let widthConstraint = NSLayoutConstraint(item: DescriptionContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -10)
        //h
        let heightConstraint = NSLayoutConstraint(item: DescriptionContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.height, multiplier: 1/6, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func initAddressContainer()
    {
        scrollView.addSubview(AddressContainer)
        //x
        let horizontalConstraint = NSLayoutConstraint(item: AddressContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: DescriptionContainer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        let verticalConstraint = NSLayoutConstraint(item: AddressContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        let widthConstraint = NSLayoutConstraint(item: AddressContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -10)
        //h
        let heightConstraint = NSLayoutConstraint(item: AddressContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.height, multiplier: 1/6, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
}

extension StoreCreation
{
    func delImage(_ sender: AnyObject)
    {
        print(sender.tag)
    }
    
    func pickLogo(_ sender: AnyObject)
    {
        print("logo")
    }
    func pickImage1(_ sender: AnyObject)
    {
        print("here1")
    }
    func pickImage2(_ sender: AnyObject)
    {
        print("here2")
    }
    func pickImage3(_ sender: AnyObject)
    {
        print("here3")
    }
    
    
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
            
        }
    }
    
    @IBAction func confirm(_ sender: Any) {//create store
        
        
    }
}
