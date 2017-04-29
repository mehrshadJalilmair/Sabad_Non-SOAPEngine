//
//  addOff.swift
//  Sabad
//
//  Created by Mehrshad JM on 3/10/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit
import DatePickerDialog
import SCLAlertView

class addOff: UIViewController , UIScrollViewDelegate , UIImagePickerControllerDelegate, UINavigationControllerDelegate , UITextFieldDelegate{
    
    var haveImage = false
    var startDate:Date!
    var endDate:Date!
    var imageAddress = ""
    @IBOutlet var scrollView: UIScrollView!
    
    let imagePicker = UIImagePickerController()
    
    let ImagesContainer : UIView! = {
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        filterView.backgroundColor = UIColor.lightGray
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
    
    let NameContainer : UIView! = {
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        filterView.backgroundColor = UIColor.lightGray
        return filterView
    }()
    let NameLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.text = "* عنوان کالا"
        label.textAlignment = .right
        label.backgroundColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let NameTextFieald: FloatLabelTextField! = {
        
        let NameTextFieald = FloatLabelTextField()
        NameTextFieald.font = UIFont.systemFont(ofSize: 10)
        NameTextFieald.textColor = UIColor.black
        NameTextFieald.textAlignment = .center
        NameTextFieald.placeholder = "عنوان کالا..."
        NameTextFieald.textAlignment = .center
        NameTextFieald.backgroundColor = UIColor.white
        NameTextFieald.tintColor = UIColor.red
        NameTextFieald.translatesAutoresizingMaskIntoConstraints = false
        return NameTextFieald
    }()
    
    
    
    let PriceContainer : UIView! = { //price
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        filterView.backgroundColor = UIColor.lightGray
        return filterView
    }()
    let PriceLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.text = "* قیمت کالا"
        label.textAlignment = .right
        label.backgroundColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let PriceTextField: FloatLabelTextField! = {
        
        let NameTextFieald = FloatLabelTextField()
        NameTextFieald.font = UIFont.systemFont(ofSize: 10)
        NameTextFieald.textColor = UIColor.black
        NameTextFieald.textAlignment = .center
        NameTextFieald.placeholder = "قیمت کالا"
        NameTextFieald.textAlignment = .center
        NameTextFieald.backgroundColor = UIColor.white
        NameTextFieald.tintColor = UIColor.red
        NameTextFieald.keyboardType = .numberPad
        NameTextFieald.translatesAutoresizingMaskIntoConstraints = false
        return NameTextFieald
    }()
    
    
    
    let OffContainer : UIView! = { // off percentage
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        filterView.backgroundColor = UIColor.lightGray
        return filterView
    }()
    let OffLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.text = "* درصد تخفیف"
        label.textAlignment = .right
        label.backgroundColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let OffTextField: FloatLabelTextField! = {
        
        let NameTextFieald = FloatLabelTextField()
        NameTextFieald.font = UIFont.systemFont(ofSize: 10)
        NameTextFieald.textColor = UIColor.black
        NameTextFieald.textAlignment = .center
        NameTextFieald.placeholder = "درصد تخفیف"
        NameTextFieald.textAlignment = .center
        NameTextFieald.backgroundColor = UIColor.white
        NameTextFieald.tintColor = UIColor.red
        NameTextFieald.keyboardType = .numberPad
        NameTextFieald.translatesAutoresizingMaskIntoConstraints = false
        return NameTextFieald
    }()
    
    
    let DescriptionContainer : UIView! = { //description
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        filterView.backgroundColor = UIColor.lightGray
        return filterView
    }()
    let DescriptionLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.text = "توضیحات"
        label.textAlignment = .right
        label.backgroundColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let DescriptionTextField: FloatLabelTextField! = {
        
        let NameTextFieald = FloatLabelTextField()
        NameTextFieald.font = UIFont.systemFont(ofSize: 10)
        NameTextFieald.textColor = UIColor.black
        NameTextFieald.textAlignment = .center
        NameTextFieald.placeholder = "توضیحات"
        NameTextFieald.textAlignment = .center
        NameTextFieald.backgroundColor = UIColor.white
        NameTextFieald.tintColor = UIColor.red
        NameTextFieald.keyboardType = .namePhonePad
        NameTextFieald.translatesAutoresizingMaskIntoConstraints = false
        return NameTextFieald
    }()
    
    let DateContainer : UIView! = { //Date
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        filterView.backgroundColor = UIColor.lightGray
        return filterView
    }()
    let FromLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.text = "از : "
        label.textAlignment = .center
        label.backgroundColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let ToLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.text = "تا : "
        label.textAlignment = .center
        label.backgroundColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var FromButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        let now = Date()
        let nowcalendar = Calendar.current
        
        let year = nowcalendar.component(.year, from: now)
        //let month = nowcalendar.component(.month, from: now)
        //let day = nowcalendar.component(.day, from: now)
        button.setTitle("روز-ماه-\(year)", for: .normal)
        //button.setImage(UIImage(named: "ic_refresh"), for: .normal)
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 2
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        //button.semanticContentAttribute = .forceRightToLeft
        button.showsTouchWhenHighlighted = true
        button.tag = 0
        button.addTarget(self, action: #selector(DatePicker(sender:)), for: .touchUpInside)
        return button
    }()
    lazy var ToButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        let now = Date()
        let nowcalendar = Calendar.current
        
        let year = nowcalendar.component(.year, from: now)
        //let month = nowcalendar.component(.month, from: now)
        //let day = nowcalendar.component(.day, from: now)
        button.setTitle("روز-ماه-\(year)", for: .normal)
        //button.setImage(UIImage(named: "ic_refresh"), for: .normal)
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 2
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        //button.semanticContentAttribute = .forceRightToLeft
        button.tag = 1
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(DatePicker(sender:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        openGettingStoreFields = false
        
        initImagesContainer()
        initNameContainer()
        initPriceContainer()
        initOffContainer()
        initDescriptionContainer()
        initDateContainer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        setScrollViewContentSize()
    }
    
    override func viewDidLayoutSubviews() {
        
        delLogoImageBtn.layer.cornerRadius = delLogoImageBtn.frame.size.width/2
        delLogoImageBtn.clipsToBounds = true
        
        NameTextFieald.layer.cornerRadius = 3
        NameTextFieald.layer.masksToBounds = true
        //NameTextFieald.hintYPadding = -100
        NameTextFieald.titleYPadding = -2
        
        PriceTextField.layer.cornerRadius = 3
        PriceTextField.layer.masksToBounds = true
        //PriceTextField.hintYPadding = -20
        PriceTextField.titleYPadding = -2
        
        OffTextField.layer.cornerRadius = 3
        OffTextField.layer.masksToBounds = true
        //OffTextField.hintYPadding = -20
        OffTextField.titleYPadding = -2
        
        DescriptionTextField.layer.cornerRadius = 3
        DescriptionTextField.layer.masksToBounds = true
        //DescriptionTextFieald.hintYPadding = -20
        DescriptionTextField.titleYPadding = -2
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tapGesture1.cancelsTouchesInView = true
        NameContainer.addGestureRecognizer(tapGesture1)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tapGesture2.cancelsTouchesInView = true
        PriceContainer.addGestureRecognizer(tapGesture2)
        
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tapGesture3.cancelsTouchesInView = true
        OffContainer.addGestureRecognizer(tapGesture3)
        
        let tapGesture6 = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tapGesture6.cancelsTouchesInView = true
        DescriptionContainer.addGestureRecognizer(tapGesture6)
        
        let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tapGesture4.cancelsTouchesInView = true
        DateContainer.addGestureRecognizer(tapGesture4)
    }
    
    func setScrollViewContentSize() {
        
        var height: CGFloat
        
        let lastViewYPos = self.DateContainer.frame.origin.y  // this is absolute positioning, not relative
        let lastViewHeight = self.DateContainer.frame.size.height
        
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
    
    func initPriceContainer()
    {
        scrollView.addSubview(PriceContainer)
        //x
        var horizontalConstraint = NSLayoutConstraint(item: PriceContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: NameContainer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        var verticalConstraint = NSLayoutConstraint(item: PriceContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        var widthConstraint = NSLayoutConstraint(item: PriceContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -10)
        //h
        var heightConstraint = NSLayoutConstraint(item: PriceContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 60)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        PriceContainer.addSubview(PriceLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: PriceLabel, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: PriceContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -3)
        //y
        verticalConstraint = NSLayoutConstraint(item: PriceLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: PriceContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: PriceLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: PriceContainer, attribute: NSLayoutAttribute.width, multiplier: 1/2, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: PriceLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 20)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        PriceContainer.addSubview(PriceTextField)
        //x
        horizontalConstraint = NSLayoutConstraint(item: PriceTextField, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: PriceContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -3)
        //y
        verticalConstraint = NSLayoutConstraint(item: PriceTextField, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: PriceLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //w
        widthConstraint = NSLayoutConstraint(item: PriceTextField, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: PriceContainer, attribute: NSLayoutAttribute.width, multiplier: 3/4, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: PriceTextField, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute , multiplier: 1, constant: 30)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func initOffContainer()
    {
        scrollView.addSubview(OffContainer)
        //x
        var horizontalConstraint = NSLayoutConstraint(item: OffContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: PriceContainer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        var verticalConstraint = NSLayoutConstraint(item: OffContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        var widthConstraint = NSLayoutConstraint(item: OffContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -10)
        //h
        var heightConstraint = NSLayoutConstraint(item: OffContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 60)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        OffContainer.addSubview(OffLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: OffLabel, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: OffContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -3)
        //y
        verticalConstraint = NSLayoutConstraint(item: OffLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: OffContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: OffLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: OffContainer, attribute: NSLayoutAttribute.width, multiplier: 1/2, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: OffLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 20)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        OffContainer.addSubview(OffTextField)
        //x
        horizontalConstraint = NSLayoutConstraint(item: OffTextField, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: OffContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -3)
        //y
        verticalConstraint = NSLayoutConstraint(item: OffTextField, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: OffLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //w
        widthConstraint = NSLayoutConstraint(item: OffTextField, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: OffContainer, attribute: NSLayoutAttribute.width, multiplier: 3/4, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: OffTextField, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute , multiplier: 1, constant: 30)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func initDescriptionContainer()
    {
        scrollView.addSubview(DescriptionContainer)
        //x
        var horizontalConstraint = NSLayoutConstraint(item: DescriptionContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: OffContainer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
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
        
        DescriptionContainer.addSubview(DescriptionTextField)
        //x
        horizontalConstraint = NSLayoutConstraint(item: DescriptionTextField, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: DescriptionContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -3)
        //y
        verticalConstraint = NSLayoutConstraint(item: DescriptionTextField, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: DescriptionLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //w
        widthConstraint = NSLayoutConstraint(item: DescriptionTextField, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: DescriptionContainer, attribute: NSLayoutAttribute.width, multiplier: 3/4, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: DescriptionTextField, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute , multiplier: 1, constant: 30)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func initDateContainer()
    {
        scrollView.addSubview(DateContainer)
        //x
        var horizontalConstraint = NSLayoutConstraint(item: DateContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: DescriptionContainer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        var verticalConstraint = NSLayoutConstraint(item: DateContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        var widthConstraint = NSLayoutConstraint(item: DateContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -10)
        //h
        var heightConstraint = NSLayoutConstraint(item: DateContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 60)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        DateContainer.addSubview(FromLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: FromLabel, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: DateContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: FromLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: DateContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: FromLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: DateContainer, attribute: NSLayoutAttribute.width, multiplier: 1/10, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: FromLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: DateContainer, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        DateContainer.addSubview(FromButton)
        //x
        horizontalConstraint = NSLayoutConstraint(item: FromButton, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: FromLabel, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: FromButton, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: DateContainer, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: FromButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: DateContainer, attribute: NSLayoutAttribute.width, multiplier: 7/20, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: FromButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 20)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        DateContainer.addSubview(ToLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: ToLabel, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: FromButton, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: ToLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: DateContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: ToLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: DateContainer, attribute: NSLayoutAttribute.width, multiplier: 1/10, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: ToLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: DateContainer, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        DateContainer.addSubview(ToButton)
        //x
        horizontalConstraint = NSLayoutConstraint(item: ToButton, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: ToLabel, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: ToButton, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: DateContainer, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: ToButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: DateContainer, attribute: NSLayoutAttribute.width, multiplier: 7/20, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: ToButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 20)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
}

extension addOff
{
    func hideKeyboard() {
        
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
            
        }
    }
    
    @IBAction func confirm(_ sender: Any) {
        
        guard let name = NameTextFieald.text, let price = PriceTextField.text , let off = OffTextField.text, let description = DescriptionTextField.text else {
            
            
            return
        }
        
        if name.isEmpty || price.isEmpty || off.isEmpty
        {
            let alertWarning = UIAlertView(title:"توجه", message: "* فیلدهای ضروری را پر کنید!", delegate:nil, cancelButtonTitle:"تایید", otherButtonTitles:"")
            alertWarning.show()
            return
        }
        
        guard let from = startDate,let to = endDate else
        {
            let alertWarning = UIAlertView(title:"توجه", message: "* دو تاریخ مورد نظر خود را کنید", delegate:nil, cancelButtonTitle:"تایید", otherButtonTitles:"")
            alertWarning.show()
            return
        }
        
        if from > to
        {
            let alertWarning = UIAlertView(title:"توجه", message: "* تاریخ پایان بعد از تاریخ شروع است!", delegate:nil, cancelButtonTitle:"تایید", otherButtonTitles:"")
            alertWarning.show()
            return
        }
        else if from == to
        {
            let alertWarning = UIAlertView(title:"توجه", message: "* تاریخ پایان با تاریخ شروع یکی است!", delegate:nil, cancelButtonTitle:"تایید", otherButtonTitles:"")
            alertWarning.show()
            return
        }

        globalAlert.showWait("", subTitle: "لطفا صبور باشید...", closeButtonTitle: "", duration: 1000, colorStyle: 0x5065A1, colorTextButton: 0x000000, circleIconImage: nil, animationStyle: SCLAnimationStyle.bottomToTop)
        
        if haveImage
        {
            myImageUploadRequest(name: name, price: price, off: off, description: description)
        }
        else
        {
            sendInfoToServer(name: name, price: price, off: off, description: description)
        }
    }
    
    func pickLogo(_ sender: AnyObject)
    {
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
        
        haveImage = true
        logo.image = image
        delLogoImageBtn.isHidden = false
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
    }
    
    func delImage(_ sender: AnyObject)
    {
        delLogoImageBtn.isHidden = true
        logo.image = UIImage(named: "nedstark")
        haveImage = false
    }
    
    func DatePicker(sender: Any)
    {
        DatePickerDialog().show(title: "DatePicker", doneButtonTitle: "تایید", cancelButtonTitle: "لغو", datePickerMode: .date) {
            (date) -> Void in
            
            guard let date = date else
            {
                return
            }
            switch (sender as AnyObject).tag!
            {
            case 0:
                
                self.FromButton.setTitle(NSString(string:String(describing: date)).substring(with: NSRange(location: 0 , length: 10)), for: UIControlState.normal)
                self.startDate = date
                break
                
            case 1:
                
                self.ToButton.setTitle(NSString(string:String(describing: date)).substring(with: NSRange(location: 0 , length: 10)), for: UIControlState.normal)
                self.endDate = date
                break
                
            default:
                break
            }
        }
    }
    
    func myImageUploadRequest(name:String , price:String , off:String ,description:String)
    {
        let myUrl = NSURL(string: "http://94.182.4.13:8012/SabadPic/Image/Upload.php?num=6")
        
        let request = NSMutableURLRequest(url:myUrl! as URL)
        request.httpMethod = "POST"
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        var imageData = Data()
        
        imageData = UIImageJPEGRepresentation(logo.image!, 0.4)!
        
        request.httpBody = createBodyWithParameters(parameters: [:], filePathKey: "uploaded_file", imageDataKey: imageData as NSData, boundary: boundary) as Data
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            
            if error != nil {
                
                DispatchQueue.main.async {
                    
                    DispatchQueue.main.async {
                        
                        globalAlert.hideView()
                        DispatchQueue.main.async {
                            
                            let alert = UIAlertController(title: "خطا در بارگذاری عکس", message: "اتصال اینترنت را بررسی کنید!", preferredStyle: UIAlertControllerStyle.alert)
                            
                            alert.addAction(UIAlertAction(title: "تایید", style: UIAlertActionStyle.default, handler: { action in
                                switch action.style{
                                case .default:
                                    
                                    break
                                    
                                case .cancel:
                                    
                                    break
                                    
                                case .destructive:
                                    
                                    break
                                }
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
                return
            }
            let httpResponse = response as? HTTPURLResponse
            
            if httpResponse?.statusCode != 200
            {
                DispatchQueue.main.async {
                    
                    globalAlert.hideView()
                    DispatchQueue.main.async {
                        
                        let alert = UIAlertController(title: "خطا در بارگذاری عکس", message: "اتصال اینترنت را بررسی کنید!", preferredStyle: UIAlertControllerStyle.alert)
                        
                        alert.addAction(UIAlertAction(title: "تایید", style: UIAlertActionStyle.default, handler: { action in
                            switch action.style{
                            case .default:
                                
                                break
                                
                            case .cancel:
                                
                                break
                                
                            case .destructive:
                                
                                break
                            }
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                return
            }
            
            self.sendInfoToServer(name: name, price: price, off: off, description: description)
        }
        task.resume()
    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData
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
        
        imageAddress = "http://94.182.4.13:8012/SabadPic/Image/Store/\(filename)"
        
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

    func sendInfoToServer(name:String , price:String , off:String ,description:String)
    {
        let phone:String = defaults.value(forKey: "phone") as! String
        var date:String = String(describing: self.endDate!)
        date = date.replacingOccurrences(of: "-", with: "/")
        date = date.replacingOccurrences(of: " +0000", with: "")
        
        var price:String = price.replacingOccurrences(of: "۰", with: "0")
        price = price.replacingOccurrences(of: "۹", with: "9")
        price = price.replacingOccurrences(of: "۸", with: "8")
        price = price.replacingOccurrences(of: "۷", with: "7")
        price = price.replacingOccurrences(of: "۶", with: "6")
        price = price.replacingOccurrences(of: "۵", with: "5")
        price = price.replacingOccurrences(of: "۴", with: "4")
        price = price.replacingOccurrences(of: "۳", with: "3")
        price = price.replacingOccurrences(of: "۲", with: "2")
        price = price.replacingOccurrences(of: "۱", with: "1")
        
        var off:String = off.replacingOccurrences(of: "۰", with: "0")
        off = off.replacingOccurrences(of: "۹", with: "9")
        off = off.replacingOccurrences(of: "۸", with: "8")
        off = off.replacingOccurrences(of: "۷", with: "7")
        off = off.replacingOccurrences(of: "۶", with: "6")
        off = off.replacingOccurrences(of: "۵", with: "5")
        off = off.replacingOccurrences(of: "۴", with: "4")
        off = off.replacingOccurrences(of: "۳", with: "3")
        off = off.replacingOccurrences(of: "۲", with: "2")
        off = off.replacingOccurrences(of: "۱", with: "1")
        
        var description:String = description.replacingOccurrences(of: "ك", with: "ک")
        description = description.replacingOccurrences(of: "ي", with: "ی")
        
        var name:String = name.replacingOccurrences(of: "ك", with: "ک")
        name = name.replacingOccurrences(of: "ي", with: "ی")
        
        let soapMessage = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><AddOff xmlns=\"http://BuyApp.ir/\"><Id>\(0)</Id><Title>\(name)</Title><EndDate>\(date)</EndDate><BeforePrice>\(price)</BeforePrice><Percent>\(off)</Percent><Description>\(description)</Description><MallId>\(selectedStore.MallId!)</MallId><stId>\(selectedStore.Id!)</stId><imgUrl>\(self.imageAddress)</imgUrl><Mobile>\(phone)</Mobile><TransactionNum></TransactionNum><Paytime></Paytime></AddOff></soap:Body></soap:Envelope>"
        
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
                if let _ = response as? HTTPURLResponse
                {
                    
                    var dictionaryData = NSDictionary()
                    
                    do
                    {
                        dictionaryData = try XMLReader.dictionary(forXMLData: data) as NSDictionary
                        
                        let mainDict3 = dictionaryData.object(forKey: "soap:Envelope") as! NSDictionary
                        let mainDict2 = mainDict3.object(forKey: "soap:Body") as! NSDictionary
                        let mainDict1 = mainDict2.object(forKey: "AddOffResponse") as! NSDictionary
                        let mainDict = mainDict1.object(forKey: "AddOffResult") as! NSDictionary
                        
                        if mainDict.count > 0{
                            
                            let mainD = NSDictionary(dictionary: mainDict as [NSObject : AnyObject])
                            var cont = mainD["text"] as? String
                            cont = "{ \"content\" : " + cont! + "}"
                            
                            let data = (cont)?.data(using: .utf8)!
                            
                            guard let _result = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : AnyObject] else{
                                
                                return
                            }
                            
                            if let _ress = _result["content"] as? [AnyObject]{
                                
                                for res in _ress
                                {
                                    if res["Result"] as! Int == -2
                                    {
                                        DispatchQueue.main.async {
                                            
                                            let alert = UIAlertController(title: "", message: "محدودیت افزودن کالا برای شما پایان یافت!", preferredStyle: UIAlertControllerStyle.alert)
                                            
                                            alert.addAction(UIAlertAction(title: "تایید", style: UIAlertActionStyle.default, handler: { action in
                                                switch action.style{
                                                case .default:
                                                    
                                                    break
                                                    
                                                case .cancel:
                                                    
                                                    break
                                                    
                                                case .destructive:
                                                    
                                                    break
                                                }
                                            }))
                                            
                                            self.present(alert, animated: true, completion: nil)
                                        }
                                    }
                                    else if res["Result"] as! Int == 1
                                    {
                                        DispatchQueue.main.async {
                                            
                                            let alert = UIAlertController(title: "", message: "تخفیف ثبت شد", preferredStyle: UIAlertControllerStyle.alert)
                                            
                                            alert.addAction(UIAlertAction(title: "تایید", style: UIAlertActionStyle.default, handler: { action in
                                                switch action.style{
                                                case .default:
                                                    
                                                    self.dismiss(animated: true, completion: {
                                                        
                                                        
                                                    })
                                                    break
                                                    
                                                case .cancel:
                                                    
                                                    break
                                                    
                                                case .destructive:
                                                    
                                                    break
                                                }
                                            }))
                                            self.present(alert, animated: true, completion: nil)
                                        }
                                        
                                    }
                                    else
                                    {
                                        DispatchQueue.main.async {
                                            
                                            let alert = UIAlertController(title: "خطای سرور", message: "تخفیف ثبت نشد!", preferredStyle: UIAlertControllerStyle.alert)
                                            
                                            alert.addAction(UIAlertAction(title: "تایید", style: UIAlertActionStyle.default, handler: { action in
                                                switch action.style{
                                                case .default:
                                                    
                                                    break
                                                    
                                                case .cancel:
                                                    
                                                    break
                                                    
                                                case .destructive:
                                                    
                                                    break
                                                }
                                            }))
                                            self.present(alert, animated: true, completion: nil)
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
                        
                    }
                }
            }
            else
            {
                DispatchQueue.main.async {
                    
                    let alert = UIAlertController(title: "خطا در دریافت", message: "اتصال اینترنت را بررسی کنید!", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "تایید", style: UIAlertActionStyle.default, handler: { action in
                        switch action.style{
                        case .default:
                            
                            break
                            
                        case .cancel:
                            
                            break
                            
                        case .destructive:
                            
                            break
                        }
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
            DispatchQueue.main.async
            {
                globalAlert.hideView()
            }
        }
        dataTask.resume()
    }
}
