//
//  UpdateStore.swift
//  Sabad
//
//  Created by Mehrshad JM on 3/8/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class UpdateStore: UIViewController , UIScrollViewDelegate , UIImagePickerControllerDelegate, UINavigationControllerDelegate , UITextFieldDelegate{
    
    var store:Store!
    
    @IBOutlet var scrollView: UIScrollView!
    
    let imagePicker = UIImagePickerController()
    enum chooseImageSource {
        case none
        case logo
        case image1
        case image2
        case image3
    }
    
    var ImagesURLS:[String] = [""]
    var imageSource = chooseImageSource.none
    var filledImageViews:[String:Bool] = ["logo":false , "image1":false , "image2":false , "image3":false]
    var filledImageViewNames:[String:String] = ["logo":"" , "image1":"" , "image2":"" , "image3":""]
    let imageKeys:[String] = ["logo" , "image1" , "image2" , "image3"]
    
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
        label.font = UIFont.systemFont(ofSize: 14)
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
        button.isHidden = true
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
        button.isHidden = true
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
        button.isHidden = true
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
        button.isHidden = true
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
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.text = "* نام فروشگاه"
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
    let ManagementLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.text = "* مدیریت"
        label.textAlignment = .right
        label.backgroundColor = UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let ManagementTextFieald: FloatLabelTextField! = {
        
        let NameTextFieald = FloatLabelTextField()
        NameTextFieald.font = UIFont.systemFont(ofSize: 14)
        NameTextFieald.textColor = UIColor.black
        NameTextFieald.textAlignment = .center
        NameTextFieald.placeholder = "امید جلالی"
        NameTextFieald.textAlignment = .center
        NameTextFieald.backgroundColor = UIColor.white
        NameTextFieald.tintColor = UIColor.red
        NameTextFieald.translatesAutoresizingMaskIntoConstraints = false
        return NameTextFieald
    }()
    
    let TellContainer : UIView! = {
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        filterView.backgroundColor = UIColor.red
        return filterView
    }()
    let TellLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.text = "تلفن"
        label.textAlignment = .right
        label.backgroundColor = UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let TellTextFieald: FloatLabelTextField! = {
        
        let NameTextFieald = FloatLabelTextField()
        NameTextFieald.font = UIFont.systemFont(ofSize: 14)
        NameTextFieald.textColor = UIColor.black
        NameTextFieald.textAlignment = .center
        NameTextFieald.placeholder = "شماره تلفن"
        NameTextFieald.textAlignment = .center
        NameTextFieald.backgroundColor = UIColor.white
        NameTextFieald.tintColor = UIColor.red
        NameTextFieald.keyboardType = .phonePad
        NameTextFieald.translatesAutoresizingMaskIntoConstraints = false
        return NameTextFieald
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
    let DescriptionLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.text = "توضیحات"
        label.textAlignment = .right
        label.backgroundColor = UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let DescriptionTextFieald: FloatLabelTextField! = {
        
        let NameTextFieald = FloatLabelTextField()
        NameTextFieald.font = UIFont.systemFont(ofSize: 14)
        NameTextFieald.textColor = UIColor.black
        NameTextFieald.textAlignment = .center
        NameTextFieald.placeholder = "توضیحات فروشگاه من"
        NameTextFieald.textAlignment = .center
        NameTextFieald.backgroundColor = UIColor.white
        NameTextFieald.tintColor = UIColor.red
        NameTextFieald.translatesAutoresizingMaskIntoConstraints = false
        return NameTextFieald
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
    let AddressLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.text = "آدرس"
        label.textAlignment = .right
        label.backgroundColor = UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let AddressTextFieald: FloatLabelTextField! = {
        
        let NameTextFieald = FloatLabelTextField()
        NameTextFieald.font = UIFont.systemFont(ofSize: 14)
        NameTextFieald.textColor = UIColor.black
        NameTextFieald.textAlignment = .center
        NameTextFieald.placeholder = "طبقه اول،خیابان سوم"
        NameTextFieald.textAlignment = .center
        NameTextFieald.backgroundColor = UIColor.white
        NameTextFieald.tintColor = UIColor.red
        NameTextFieald.translatesAutoresizingMaskIntoConstraints = false
        return NameTextFieald
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        openGettingStoreFields = false
        
        initImagesContainer()
        initNameContainer()
        initManagementContainer()
        initTellContainer()
        initDescriptionContainer()
        initAddressContainer()
        myInit()
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
        
        NameTextFieald.layer.cornerRadius = 3
        NameTextFieald.layer.masksToBounds = true
        //NameTextFieald.hintYPadding = -100
        NameTextFieald.titleYPadding = -2
        
        ManagementTextFieald.layer.cornerRadius = 3
        ManagementTextFieald.layer.masksToBounds = true
        //ManagementTextFieald.hintYPadding = -20
        ManagementTextFieald.titleYPadding = -2
        
        DescriptionTextFieald.layer.cornerRadius = 3
        DescriptionTextFieald.layer.masksToBounds = true
        //DescriptionTextFieald.hintYPadding = -20
        DescriptionTextFieald.titleYPadding = -2
        
        AddressTextFieald.layer.cornerRadius = 3
        AddressTextFieald.layer.masksToBounds = true
        //AddressTextFieald.hintYPadding = -20
        AddressTextFieald.titleYPadding = -2
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tapGesture1.cancelsTouchesInView = true
        NameContainer.addGestureRecognizer(tapGesture1)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tapGesture2.cancelsTouchesInView = true
        ManagementContainer.addGestureRecognizer(tapGesture2)
        
        let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tapGesture4.cancelsTouchesInView = true
        DescriptionContainer.addGestureRecognizer(tapGesture4)
        
        let tapGesture5 = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tapGesture5.cancelsTouchesInView = true
        AddressContainer.addGestureRecognizer(tapGesture5)
        
        let tapGesture6 = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tapGesture6.cancelsTouchesInView = true
        TellLabel.addGestureRecognizer(tapGesture6)
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
        var heightConstraint = NSLayoutConstraint(item: NameContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 60)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        NameContainer.addSubview(NameLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: NameLabel, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: NameContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -3)
        //y
        verticalConstraint = NSLayoutConstraint(item: NameLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: NameContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: NameLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: NameContainer, attribute: NSLayoutAttribute.width, multiplier: 1/2, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: NameLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 20)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        NameContainer.addSubview(NameTextFieald)
        //x
        horizontalConstraint = NSLayoutConstraint(item: NameTextFieald, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: NameContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -3)
        //y
        verticalConstraint = NSLayoutConstraint(item: NameTextFieald, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: NameLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //w
        widthConstraint = NSLayoutConstraint(item: NameTextFieald, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: NameContainer, attribute: NSLayoutAttribute.width, multiplier: 3/4, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: NameTextFieald, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute , multiplier: 1, constant: 30)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func initManagementContainer()
    {
        scrollView.addSubview(ManagementContainer)
        //x
        var horizontalConstraint = NSLayoutConstraint(item: ManagementContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: NameContainer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        var verticalConstraint = NSLayoutConstraint(item: ManagementContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        var widthConstraint = NSLayoutConstraint(item: ManagementContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -10)
        //h
        var heightConstraint = NSLayoutConstraint(item: ManagementContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 60)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        ManagementContainer.addSubview(ManagementLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: ManagementLabel, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: ManagementContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -3)
        //y
        verticalConstraint = NSLayoutConstraint(item: ManagementLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: ManagementContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: ManagementLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: ManagementContainer, attribute: NSLayoutAttribute.width, multiplier: 1/2, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: ManagementLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 20)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        ManagementContainer.addSubview(ManagementTextFieald)
        //x
        horizontalConstraint = NSLayoutConstraint(item: ManagementTextFieald, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: ManagementContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -3)
        //y
        verticalConstraint = NSLayoutConstraint(item: ManagementTextFieald, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: ManagementLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //w
        widthConstraint = NSLayoutConstraint(item: ManagementTextFieald, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: ManagementContainer, attribute: NSLayoutAttribute.width, multiplier: 3/4, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: ManagementTextFieald, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute , multiplier: 1, constant: 30)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func initTellContainer()
    {
        scrollView.addSubview(TellContainer)
        //x
        var horizontalConstraint = NSLayoutConstraint(item: TellContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: ManagementContainer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        var verticalConstraint = NSLayoutConstraint(item: TellContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        var widthConstraint = NSLayoutConstraint(item: TellContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -10)
        //h
        var heightConstraint = NSLayoutConstraint(item: TellContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 60)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        TellContainer.addSubview(TellLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: TellLabel, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: TellContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -3)
        //y
        verticalConstraint = NSLayoutConstraint(item: TellLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: TellContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: TellLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: TellContainer, attribute: NSLayoutAttribute.width, multiplier: 1/2, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: TellLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 20)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        TellContainer.addSubview(TellTextFieald)
        //x
        horizontalConstraint = NSLayoutConstraint(item: TellTextFieald, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: TellContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -3)
        //y
        verticalConstraint = NSLayoutConstraint(item: TellTextFieald, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: TellLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //w
        widthConstraint = NSLayoutConstraint(item: TellTextFieald, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: TellContainer, attribute: NSLayoutAttribute.width, multiplier: 3/4, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: TellTextFieald, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute , multiplier: 1, constant: 30)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    
    func initDescriptionContainer()
    {
        scrollView.addSubview(DescriptionContainer)
        //x
        var horizontalConstraint = NSLayoutConstraint(item: DescriptionContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: TellContainer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        var verticalConstraint = NSLayoutConstraint(item: DescriptionContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        var widthConstraint = NSLayoutConstraint(item: DescriptionContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -10)
        //h
        var heightConstraint = NSLayoutConstraint(item: DescriptionContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 60)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        DescriptionContainer.addSubview(DescriptionLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: DescriptionLabel, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: DescriptionContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -3)
        //y
        verticalConstraint = NSLayoutConstraint(item: DescriptionLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: DescriptionContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: DescriptionLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: DescriptionContainer, attribute: NSLayoutAttribute.width, multiplier: 1/2, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: DescriptionLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 20)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        DescriptionContainer.addSubview(DescriptionTextFieald)
        //x
        horizontalConstraint = NSLayoutConstraint(item: DescriptionTextFieald, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: DescriptionContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -3)
        //y
        verticalConstraint = NSLayoutConstraint(item: DescriptionTextFieald, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: DescriptionLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //w
        widthConstraint = NSLayoutConstraint(item: DescriptionTextFieald, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: DescriptionContainer, attribute: NSLayoutAttribute.width, multiplier: 3/4, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: DescriptionTextFieald, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute , multiplier: 1, constant: 30)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func initAddressContainer()
    {
        scrollView.addSubview(AddressContainer)
        //x
        var horizontalConstraint = NSLayoutConstraint(item: AddressContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: DescriptionContainer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        var verticalConstraint = NSLayoutConstraint(item: AddressContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        var widthConstraint = NSLayoutConstraint(item: AddressContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -10)
        //h
        var heightConstraint = NSLayoutConstraint(item: AddressContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 60)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        AddressContainer.addSubview(AddressLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: AddressLabel, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: AddressContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -3)
        //y
        verticalConstraint = NSLayoutConstraint(item: AddressLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: AddressContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: AddressLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: AddressContainer, attribute: NSLayoutAttribute.width, multiplier: 1/2, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: AddressLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 20)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        AddressContainer.addSubview(AddressTextFieald)
        //x
        horizontalConstraint = NSLayoutConstraint(item: AddressTextFieald, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: AddressContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -3)
        //y
        verticalConstraint = NSLayoutConstraint(item: AddressTextFieald, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: AddressLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //w
        widthConstraint = NSLayoutConstraint(item: AddressTextFieald, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: DescriptionContainer, attribute: NSLayoutAttribute.width, multiplier: 3/4, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: AddressTextFieald, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute , multiplier: 1, constant: 30)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func myInit()
    {
        self.NameTextFieald.text = (self.store.stName as! String)
        self.ManagementTextFieald.text = (self.store.stManager as! String)
        self.TellTextFieald.text = (self.store.stTel as! String)
        self.DescriptionTextFieald.text = (self.store.stDescription as! String)
        self.AddressTextFieald.text = (self.store.stAddress as! String)
    
        if(!(self.store.urlImage as! String).contains("http") || self.store.urlImage as! String == "" || self.store.urlImage is NSNull)
        {
            
        }
        else
        {
            self.logo.loadImageUsingCacheWithUrlString(urlString: self.store.urlImage as! String)
            filledImageViewNames["logo"] = (self.store.urlImage as! String)
            self.delLogoImageBtn.isHidden = false
            var i = 0
            for url in self.ImagesURLS {
                
                if url == (self.store.urlImage as! String)
                {
                    self.ImagesURLS.remove(at: i)
                    break
                }
                i += 1
            }
        }
        
        if ImagesURLS.count == 1 {
            
            self.image1.loadImageUsingCacheWithUrlString(urlString: ImagesURLS[0])
            filledImageViewNames["image1"] = ImagesURLS[0]
            self.delImage1Btn.isHidden = false
        }
        else if ImagesURLS.count == 2 {
            
            self.image1.loadImageUsingCacheWithUrlString(urlString: ImagesURLS[0])
            self.image2.loadImageUsingCacheWithUrlString(urlString: ImagesURLS[1])
            filledImageViewNames["image1"] = ImagesURLS[0]
            filledImageViewNames["image2"] = ImagesURLS[1]
            self.delImage1Btn.isHidden = false
            self.delImage2Btn.isHidden = false
        }
        else if ImagesURLS.count == 3 {
            
            self.image1.loadImageUsingCacheWithUrlString(urlString: ImagesURLS[0])
            self.image2.loadImageUsingCacheWithUrlString(urlString: ImagesURLS[1])
            self.image3.loadImageUsingCacheWithUrlString(urlString: ImagesURLS[2])
            filledImageViewNames["image1"] = ImagesURLS[0]
            filledImageViewNames["image2"] = ImagesURLS[1]
            filledImageViewNames["image3"] = ImagesURLS[2]
            self.delImage1Btn.isHidden = false
            self.delImage2Btn.isHidden = false
            self.delImage3Btn.isHidden = false
        }
    }
}

extension UpdateStore
{
    func delImage(_ sender: AnyObject)
    {
        ///if imageSource == .none
        //{
            //return
        //}
        
        switch sender.tag! {
            
        case 0:
            filledImageViews["logo"] = false
            delLogoImageBtn.isHidden = true
            logo.image = UIImage(named: "nedstark")
            imageSource = .none
            filledImageViewNames["logo"] = ""
            break
            
        case 1:
            filledImageViews["image1"] = false
            delImage1Btn.isHidden = true
            image1.image = UIImage(named: "nedstark")
            imageSource = .none
            filledImageViewNames["image1"] = ""
            break
            
        case 2:
            filledImageViews["image2"] = false
            delImage2Btn.isHidden = true
            image2.image = UIImage(named: "nedstark")
            imageSource = .none
            filledImageViewNames["image2"] = ""
            break
            
        case 3:
            filledImageViews["image3"] = false
            delImage3Btn.isHidden = true
            image3.image = UIImage(named: "nedstark")
            imageSource = .none
            filledImageViewNames["image3"] = ""
            break
            
        default:
            break
        }
    }
    
    func pickLogo(_ sender: AnyObject)
    {
        print("logo")
        imageSource = .logo
        chooseSource()
    }
    func pickImage1(_ sender: AnyObject)
    {
        print("here1")
        imageSource = .image1
        chooseSource()
    }
    func pickImage2(_ sender: AnyObject)
    {
        print("here2")
        imageSource = .image2
        chooseSource()
    }
    func pickImage3(_ sender: AnyObject)
    {
        print("here3")
        imageSource = .image3
        chooseSource()
    }
    func chooseSource()
    {
        let alert:UIAlertController=UIAlertController(title: "انتخاب عکس از :", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cameraAction = UIAlertAction(title: "دوربین", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "گالری", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallary()
        }
        let cancelAction = UIAlertAction(title: "لغو", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
        }
        
        // Add the actions
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    func openCamera()
    {
        
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            self .present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alertWarning = UIAlertView(title:"توجه", message: "دوربین در دسترس نیست!", delegate:nil, cancelButtonTitle:"تایید", otherButtonTitles:"")
            alertWarning.show()
            
        }
    }
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    //PickerView Delegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var image : UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"]  as? UIImage{
            
            image = editedImage
        }
        else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            
            image = originalImage
        }
        
        switch imageSource {
            
        case .logo:
            filledImageViews["logo"] = true
            logo.image = image
            delLogoImageBtn.isHidden = false
            break
            
        case .image1:
            filledImageViews["image1"] = true
            image1.image = image
            delImage1Btn.isHidden = false
            break
            
        case .image2:
            filledImageViews["image2"] = true
            image2.image = image
            delImage2Btn.isHidden = false
            break
            
        case .image3:
            filledImageViews["image3"] = true
            image3.image = image
            delImage3Btn.isHidden = false
            break
            
        default:
            break
        }
        //imagePicker.image=info[UIImagePickerControllerOriginalImage] as? UIImage
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        print("picker cancel.")
        imageSource = .none
    }
    
    
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
            
        }
    }
    
    @IBAction func confirm(_ sender: Any) {//create store
        
        print(filledImageViews)
        
        guard let name = NameTextFieald.text, let managagment = ManagementTextFieald.text, let description = DescriptionTextFieald.text, let address = AddressTextFieald.text , let tell = TellTextFieald.text else {
            
            
            print("Form is not valid")
            return
        }
        
        if name.isEmpty || managagment.isEmpty
        {
            let alertWarning = UIAlertView(title:"توجه", message: "* فیلدهای ضروری را پر کنید!", delegate:nil, cancelButtonTitle:"تایید", otherButtonTitles:"")
            alertWarning.show()
            return
        }
        
        var haveImage = false
        for (_ , value) in filledImageViews {
            
            if value == true {
                
                haveImage = true
                break
            }
        }
        
        if haveImage
        {
            myImageUploadRequest(name: name, managament: managagment , tell: tell, description: description, address: address , imageKeyIndex: 0)
        }
        else
        {
            sendInfoToServer(name: name, managament: managagment , tell: tell, description: description, address: address)
        }
    }
    
    func hideKeyboard() {
        
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
}

extension UpdateStore
{
    
    
    func myImageUploadRequest(name:String , managament:String , tell:String , description:String , address:String , imageKeyIndex:Int)
    {
        
        var key = "logo"
        switch imageKeyIndex {
            
        case 0:
            key = "logo"
            break
            
        case 1:
            key = "image1"
            break
            
        case 2:
            key = "image2"
            break
            
        case 3:
            key = "image3"
            break
            
        default:
            break
        }
        
        if imageKeyIndex >= filledImageViews.count
        {
            sendInfoToServer(name: name, managament: managament , tell: tell, description: description, address: address)
            return
        }
        
        if filledImageViews[key] == true
        {
            
        }
        else
        {
            myImageUploadRequest(name: name, managament: managament, tell: tell, description: description, address: address , imageKeyIndex: imageKeyIndex + 1)
            return
        }
        
        let myUrl = NSURL(string: "http://94.182.4.13:8012/SabadPic/Image/Upload.php?num=6")
        
        let request = NSMutableURLRequest(url:myUrl! as URL)
        request.httpMethod = "POST"
        
        //let param = [
        
        //"firstName"  : "Sergey",
        //"lastName"    : "Kargopolov",
        //"userId"    : "9"
        //]
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        var imageData = Data()
        
        switch key {
            
        case "logo":
            imageData = UIImageJPEGRepresentation(logo.image!, 0.4)!
            break
            
        case "image1":
            imageData = UIImageJPEGRepresentation(image1.image!, 0.4)!
            break
            
        case "image2":
            imageData = UIImageJPEGRepresentation(image2.image!, 0.4)!
            break
            
        case "image3":
            imageData = UIImageJPEGRepresentation(image3.image!, 0.4)!
            break
            
        default:
            break
        }
        
        request.httpBody = createBodyWithParameters(parameters: [:], filePathKey: "uploaded_file", imageDataKey: imageData as NSData, boundary: boundary , imageKey: key) as Data
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            
            if error != nil {
                
                DispatchQueue.main.async {
                    
                    
                }
                print("error=\(error)")
                return
            }
            let httpResponse = response as? HTTPURLResponse
            
            if httpResponse?.statusCode != 200
            {
                DispatchQueue.main.async {
                    
                    
                }
                return
            }
            
            self.myImageUploadRequest(name: name, managament: managament, tell: tell, description: description, address: address , imageKeyIndex: imageKeyIndex + 1)
        }
        task.resume()
    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String , imageKey:String) -> NSData
    {
        let body = NSMutableData();
        
        if parameters != nil {
            
            
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
            
        }
        
        let now = Date()
        let nowcalendar = Calendar.current
        
        let year = nowcalendar.component(.year, from: now)
        let month = nowcalendar.component(.month, from: now)
        let day = nowcalendar.component(.day, from: now)
        let hour = nowcalendar.component(.hour, from: now)
        let min = nowcalendar.component(.minute, from: now)
        let sec = nowcalendar.component(.second, from: now)
        
        let nowDate = "\(year)\(month)\(day)\(hour)\(min)\(sec)"
        
        
        let filename = "ios_\(nowDate).jpg"
        
        filledImageViewNames[imageKey] = "http://94.182.4.13:8012/SabadPic/Image/Store/\(filename)"
        
        let mimetype = "image/jpg"
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        
        body.appendString(string: "--\(boundary)--\r\n")
        return body
    }
    
    func generateBoundaryString() -> String {
        
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func sendInfoToServer(name:String , managament:String , tell:String , description:String , address:String)
    {
        let soapMessage = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><CreateStore xmlns=\"http://BuyApp.ir/\"><stId>\(self.store.Id!)</stId><stName>\(name)</stName><stCode></stCode><stAddress>\(address)</stAddress><stManager>\(managament)</stManager><stDescription>\(description)</stDescription><stTel>\(tell)</stTel><MallId>\(storeMall)</MallId><img>\(filledImageViewNames["logo"]!)</img><img1>\(filledImageViewNames["image1"]!)</img1><img2>\(filledImageViewNames["image2"]!)</img2><img3>\(filledImageViewNames["image3"]!)</img3></CreateStore></soap:Body></soap:Envelope>"
        print(soapMessage)
        
        let soapLenth = String(soapMessage.characters.count)
        let theUrlString = Request.webServiceAddress
        let theURL = NSURL(string: theUrlString)
        let mutableR = NSMutableURLRequest(url: theURL! as URL)
        
        mutableR.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        //mutableR.addValue("text/html; charset=utf-8", forHTTPHeaderField: "Content-Type")
        mutableR.addValue(soapLenth, forHTTPHeaderField: "Content-Length")
        mutableR.httpMethod = "POST"
        mutableR.httpBody = soapMessage.data(using: String.Encoding.utf8)
        
        let configuration: URLSessionConfiguration = URLSessionConfiguration.default
        let session : URLSession = URLSession(configuration: configuration)
        
        let dataTask = session.dataTask(with: mutableR as URLRequest) {data,response,error in
            
            if error == nil
            {
                if let httpResponse = response as? HTTPURLResponse
                {
                    print(httpResponse.statusCode)
                    
                    var dictionaryData = NSDictionary()
                    
                    do
                    {
                        dictionaryData = try XMLReader.dictionary(forXMLData: data) as NSDictionary
                        
                        let mainDict3 = dictionaryData.object(forKey: "soap:Envelope") as! NSDictionary
                        let mainDict2 = mainDict3.object(forKey: "soap:Body") as! NSDictionary
                        let mainDict1 = mainDict2.object(forKey: "CreateStoreResponse") as! NSDictionary
                        let mainDict = mainDict1.object(forKey: "CreateStoreResult") as! NSDictionary
                        
                        if mainDict.count > 0{
                            
                            let mainD = NSDictionary(dictionary: mainDict as [NSObject : AnyObject])
                            var cont = mainD["text"] as? String
                            cont = "{ \"content\" : " + cont! + "}"
                            
                            //print(cont as Any)
                            
                            let data = (cont)?.data(using: .utf8)!
                            
                            guard let _result = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : AnyObject] else{
                                
                                return
                            }
                            
                            if let _ress = _result["content"] as? [AnyObject]{
                                
                                for res in _ress
                                {
                                    if res["Result"] as! Int == 0
                                    {
                                        
                                    }
                                    else if res["Result"] as! Int == 1
                                    {
                                        DispatchQueue.main.async {
                                            
                                            self.dismiss(animated: true, completion: {
                                                
                                                
                                            })
                                        }
                                    }
                                }
                            }
                            
                        }
                        else{
                            
                        }
                    }
                    catch
                    {
                        //print("Your Dictionary value nil")
                    }
                }
            }
            else
            {
                print("nil data")
            }
        }
        dataTask.resume()
    }
}

extension NSMutableData {
    
    func appendString(string: String) {
        
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

