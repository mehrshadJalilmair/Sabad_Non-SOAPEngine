//
//  StoreModal.swift
//  Sabad
//
//  Created by Mehrshad JM on 2/9/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.

import UIKit

class StoreModal: UIViewController , UIScrollViewDelegate , LIHSliderDelegate , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    let cellId = "Item"
    
    //views
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var fav_icon: UIButton!
    
    //collection view
    lazy var collectionView : UICollectionView! =
        {
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.sectionInset = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
            let width = ((SCREEN_SIZE.width) / 2) - 10
            let height = ((SCREEN_SIZE.width) / 2) + width/2 - 20
            layout.itemSize = CGSize(width: width, height: height)
            
            let collectionView : UICollectionView = UICollectionView(frame: self.scrollView.frame, collectionViewLayout: layout)
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(GoodCell.self, forCellWithReuseIdentifier: self.cellId)
            collectionView.backgroundColor = UIColor.white
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.keyboardDismissMode = .onDrag
            return collectionView
    }()
    let collectionViewSupporterLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont(name: "Vazir", size: 10)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        label.text = "کالایی ثبت نشده است!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //slider (container + LIHSliderViewController)
    var slider1: LIHSlider!
    let slider1Container : UIView! = {
        
        let slider1Container = UIView()
        slider1Container.backgroundColor = UIColor.white
        slider1Container.translatesAutoresizingMaskIntoConstraints = false
        return slider1Container
    }()
    let slider1ContainerSupportImageView : UIImageView! = { //over slider when no image
        
        let slider1ContainerSupportImageView = UIImageView()
        slider1ContainerSupportImageView.translatesAutoresizingMaskIntoConstraints = false
        return slider1ContainerSupportImageView
    }()
    fileprivate var sliderVc1: LIHSliderViewController!
    
    let name: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont(name: "Vazir", size: 10)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let manager: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont(name: "Vazir", size: 10)
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let tell: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont(name: "Vazir", size: 10)
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let desc: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont(name: "Vazir", size: 10)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let address: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont(name: "Vazir", size: 10)
        label.textColor = UIColor.black
        label.numberOfLines = 3
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var followingButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 35, g: 35, b: 35)
        button.setTitle("پیگیری", for: .normal)
        //button.setImage(UIImage(named: "ic_refresh"), for: .normal)
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 2
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Vazir-Bold", size: 12)
        //button.semanticContentAttribute = .forceRightToLeft
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(follow), for: .touchUpInside)
        return button
    }()
    
    let containersContainer : UIView! = {
        
        let containersContainer = UIView()
        containersContainer.backgroundColor = UIColor.green
        containersContainer.translatesAutoresizingMaskIntoConstraints = false
        return containersContainer
    }()
    
    let followersCountContainer : UIView! = {
        
        let followersCountContainer = UIView()
        followersCountContainer.translatesAutoresizingMaskIntoConstraints = false
        return followersCountContainer
    }()
    let followerLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont(name: "Vazir", size: 10)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.backgroundColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var followerIcon:UIButton! = {
        
        let followerIcon = UIButton(type: .system)
        followerIcon.titleLabel?.font = UIFont(name: "Vazir-Bold", size: 12)
        followerIcon.setImage(UIImage(named :"ic_touch_app_36pt"), for: UIControlState.normal)
        //followerIcon.addTarget(self, action: #selector(setAbusesetAbuse), for: UIControlEvents.touchUpInside)
        followerIcon.translatesAutoresizingMaskIntoConstraints = false
        followerIcon.backgroundColor = UIColor.lightGray
        followerIcon.isUserInteractionEnabled = false
        followerIcon.tag = self.store.Id as! Int
        followerIcon.tintColor = UIColor.black
        
        return followerIcon
    }()
    
    let abuseContainer : UIView! = {
        
        let abuseContainer = UIView()
        abuseContainer.translatesAutoresizingMaskIntoConstraints = false
        return abuseContainer
    }()
    lazy var abuseLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont(name: "Vazir", size: 10)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.text = "ثبت تخلف"
        label.backgroundColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tag = self.store.Id as! Int
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setAbuse)))
        return label
    }()
    lazy var setAbuseButton:UIButton! = {
        
        let icon = UIButton(type: .system)
        icon.setImage(UIImage(named :"ic_info_36pt"), for: UIControlState.normal)
        icon.addTarget(self, action: #selector(setAbuse), for: UIControlEvents.touchUpInside)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.backgroundColor = UIColor.lightGray
        icon.tintColor = UIColor.black
        icon.tag = self.store.Id as! Int
        icon.titleLabel?.font = UIFont(name: "Vazir-Bold", size: 12)
        return icon
    }()

    
    //vars
    var store:Store!
    var sliderImages:[Ad] = [Ad]()
    var sliderImagesURLS:[String] = [""]
    var storeGoods:[Good] = [Good]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setInits()
        initSlider()
        GetImagesAndSet(stId: self.store.Id as! Int)
        initOtherViews()
        initCollectionView()
        QueryOnDB(stId: self.store.Id as! Int)
    }
    
    override func viewDidLayoutSubviews() {
        
        //add slider to container
        self.sliderVc1!.view.frame = self.slider1Container.frame
    }
    
    func setInits()
    {
        selectedStore = self.store
        
        if defaults.object(forKey: "stId\(self.store.Id!)") == nil
        {
            fav_icon.setImage(UIImage(named: "favorite_unset"), for: UIControlState.normal)
        }
        else
        {
            fav_icon.setImage(UIImage(named: "favorite_set"), for: UIControlState.normal)
        }
        
        if defaults.object(forKey: "follow\(self.store.Id!)") == nil
        {
            followingButton.backgroundColor = UIColor(r: 35, g: 35, b: 35)
        }
        else
        {
            followingButton.backgroundColor = UIColor(r: 0, g: 200, b: 0)
        }
    }
    
    func initSlider()
    {
        //add slider container to view + autoLayouting
        scrollView.addSubview(slider1Container)
        
        //x
        var horizontalConstraint = NSLayoutConstraint(item: slider1Container, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //y
        var verticalConstraint = NSLayoutConstraint(item: slider1Container, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //w
        var widthConstraint = NSLayoutConstraint(item: slider1Container, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        var heightConstraint = NSLayoutConstraint(item: slider1Container, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        slider1 = LIHSlider(images: sliderImagesURLS)

        self.sliderVc1  = LIHSliderViewController(slider: slider1)
        sliderVc1.delegate = self
        self.addChildViewController(self.sliderVc1)
        self.scrollView.addSubview(self.sliderVc1.view)
        self.sliderVc1.didMove(toParentViewController: self)
        
        
        scrollView.addSubview(slider1ContainerSupportImageView)
        //x
        horizontalConstraint = NSLayoutConstraint(item: slider1ContainerSupportImageView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: slider1ContainerSupportImageView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: slider1ContainerSupportImageView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: slider1ContainerSupportImageView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        slider1ContainerSupportImageView.isHidden = false
        self.scrollView.bringSubview(toFront: slider1ContainerSupportImageView)
        slider1ContainerSupportImageView.loadImageUsingCacheWithUrlString(urlString: self.store.urlImage as! String)
    }
    
    func initOtherViews()
    {
        scrollView.addSubview(followingButton)
        //x
        var horizontalConstraint = NSLayoutConstraint(item: followingButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: slider1Container, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        var verticalConstraint = NSLayoutConstraint(item: followingButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        var widthConstraint = NSLayoutConstraint(item: followingButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -20)
        //h
        var heightConstraint = NSLayoutConstraint(item: followingButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 30)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        
        scrollView.addSubview(containersContainer)
        //x
        horizontalConstraint = NSLayoutConstraint(item: containersContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: followingButton, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        verticalConstraint = NSLayoutConstraint(item: containersContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: containersContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: containersContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 30)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        
        containersContainer.addSubview(followersCountContainer)
        //x
        horizontalConstraint = NSLayoutConstraint(item: followersCountContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: containersContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: followersCountContainer, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: containersContainer, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: followersCountContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: containersContainer, attribute: NSLayoutAttribute.width, multiplier: 1/2, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: followersCountContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: containersContainer, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        containersContainer.addSubview(abuseContainer)
        //x
        horizontalConstraint = NSLayoutConstraint(item: abuseContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: containersContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: abuseContainer, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: followersCountContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: +1)
        //w
        widthConstraint = NSLayoutConstraint(item: abuseContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: containersContainer, attribute: NSLayoutAttribute.width, multiplier: 1/2, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: abuseContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: containersContainer, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        followersCountContainer.addSubview(followerLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: followerLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: followersCountContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: followerLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: followersCountContainer, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: followerLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: followersCountContainer, attribute: NSLayoutAttribute.width, multiplier: 1 , constant: -30)
        //h
        heightConstraint = NSLayoutConstraint(item: followerLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: followersCountContainer, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        followerLabel.text = "\(self.store.Followers!) دنبال کننده"
        
        
        followersCountContainer.addSubview(followerIcon)
        //x
        horizontalConstraint = NSLayoutConstraint(item: followerIcon, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: followerLabel, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: followerIcon, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: followerLabel, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: followerIcon, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: followersCountContainer, attribute: NSLayoutAttribute.height, multiplier: 1 , constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: followerIcon, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: followersCountContainer, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
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

        
        scrollView.addSubview(name)
        //x
        horizontalConstraint = NSLayoutConstraint(item: name, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: containersContainer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: name, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: -5)
        //w
        widthConstraint = NSLayoutConstraint(item: name, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: name, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 15)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        name.text = self.store.stName as? String
        
        
        scrollView.addSubview(manager)
        //x
        horizontalConstraint = NSLayoutConstraint(item: manager, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: name, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: manager, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: -5)
        //w
        widthConstraint = NSLayoutConstraint(item: manager, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: manager, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 15)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        manager.text = self.store.stManager as? String
        
        
        scrollView.addSubview(tell)
        //x
        horizontalConstraint = NSLayoutConstraint(item: tell, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: manager, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: tell, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: -5)
        //w
        widthConstraint = NSLayoutConstraint(item: tell, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: tell, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 15)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        tell.text = self.store.stTel as? String
        
        
        scrollView.addSubview(desc)
        //x
        horizontalConstraint = NSLayoutConstraint(item: desc, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: tell, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: desc, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: -5)
        //w
        widthConstraint = NSLayoutConstraint(item: desc, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: desc, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 15)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        desc.text = self.store.stDescription as? String
        
        scrollView.addSubview(address)
        //x
        horizontalConstraint = NSLayoutConstraint(item: address, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: desc, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: address, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: -5)
        //w
        widthConstraint = NSLayoutConstraint(item: address, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: address, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 30)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        address.text = self.store.stAddress as? String
        address.numberOfLines = 3
    }
    
    func initCollectionView()
    {
        scrollView.addSubview(collectionView)
        let width = ((SCREEN_SIZE.width) / 2) - 10
        let height = ((SCREEN_SIZE.width) / 2) + width/2 - 20
        
        //x
        let horizontalConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //y
        let verticalConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.address, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //w
        let widthConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        let heightConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: height + 2)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        collectionView.backgroundColor = UIColor.white
    }
}

extension StoreModal
{
    //press image slider index
    func itemPressedAtIndex(index: Int) {
        
    }
    
    func follow()
    {
        if defaults.object(forKey: "userId") == nil
        {
            setFollow(stId: self.store.Id as! Int, userId: 0 , saveUserId:true)
        }
        else
        {
            let userId = defaults.value(forKey: "userId") as! Int
            setFollow(stId: self.store.Id as! Int, userId: userId , saveUserId:false)
        }
    }
    
    func setAbuse()
    {
        abuseStore = self.store
        abuseType = 0
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
            }
            .didCloseHandler { popup in
                
            }
        
        let container = setAbuseController.instance()
        container.closeHandler = { _ in
            popup.dismiss()
        }
        popup.show(container)
        
    }
    
    @IBAction func dismidd(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
        }
    }
    @IBAction func Neshan(_ sender: Any) {
        
        if defaults.object(forKey: "stId\(self.store.Id!)") == nil
        {
            fav_icon.setImage(UIImage(named: "favorite_set"), for: UIControlState.normal)
            defaults.set(self.store.Id, forKey: "stId\(self.store.Id!)")
            defaults.set(self.store.stName, forKey: "stName\(self.store.Id!)")
            defaults.set(self.store.MallId, forKey: "MallId\(self.store.Id!)")
            defaults.set(self.store.stTel, forKey: "stTel\(self.store.Id!)")
            defaults.set(self.store.stManager, forKey: "stManager\(self.store.Id!)")
            defaults.set(self.store.stDescription, forKey: "stDescription\(self.store.Id!)")
            defaults.set(self.store.stAddress, forKey: "stAddress\(self.store.Id!)")
            defaults.set(self.store.stCode, forKey: "stCode\(self.store.Id!)")
            defaults.set(self.store.Followers, forKey: "Followers\(self.store.Id!)")
            defaults.set(self.store.Mobile, forKey: "Mobile\(self.store.Id!)")
            defaults.set(self.store.stActive, forKey: "stActive\(self.store.Id!)")
            defaults.set(self.store.pm, forKey: "pm\(self.store.Id!)")
            defaults.set(self.store.urlImage, forKey: "urlImage\(self.store.Id!)")
        }
        else
        {
            fav_icon.setImage(UIImage(named: "favorite_unset"), for: UIControlState.normal)
            defaults.removeObject(forKey: "stId\(self.store.Id!)")
            defaults.removeObject(forKey: "stName\(self.store.Id!)")
            defaults.removeObject(forKey: "MallId\(self.store.Id!)")
            defaults.removeObject(forKey: "stTel\(self.store.Id!)")
            defaults.removeObject(forKey: "stManager\(self.store.Id!)")
            defaults.removeObject(forKey: "stDescription\(self.store.Id!)")
            defaults.removeObject(forKey: "stAddress\(self.store.Id!)")
            defaults.removeObject(forKey: "stCode\(self.store.Id!)")
            defaults.removeObject(forKey: "Followers\(self.store.Id!)")
            defaults.removeObject(forKey: "Mobile\(self.store.Id!)")
            defaults.removeObject(forKey: "stActive\(self.store.Id!)")
            defaults.removeObject(forKey: "urlImage\(self.store.Id!)")
        }
    }
    @IBAction func Call(_ sender: Any) {
        
        
        if let number = self.store.stTel
        {
            if number  as! String != "" {
                
                if let url = NSURL(string: "tel://\(number)") {
                    
                    UIApplication.shared.openURL(url as URL)
                }
            }
        }
    }
    
    //collView funcs
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return storeGoods.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GoodCell
        
        let good  = storeGoods[indexPath.row]
        
        cell.iconInTopRightView.image = UIImage(named: "ic_visibility_36pt")
        cell.labelInTopRightView.text =  "\(good.Views!) بازدید"
        
        cell.offLabel.text = "\(good.offPercent!) درصد    "
        cell.mainTimeLabel.text = "\(good.mainTime!) روز"
        cell.titleLabel.text = good.offTitle as! String?
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(good.offBeforePrice!) تومان")
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
        cell.alreadyPriceLabel.attributedText = attributeString
        
        let newPrice = (good.offBeforePrice as! Int)  - ((good.offBeforePrice as! Int) * (good.offPercent  as! Int) / 100)
        cell.newPriceLabel.text = "\(newPrice) تومان"
        
        if ((good.offPercent as! Int == 0) || (good.mainTime! < 0))
        {
            cell.offLabel.isHidden = true
            cell.mainTimeLabel.isHidden = true
            cell.alreadyPriceLabel.text = "\(good.offBeforePrice!) تومان"
            cell.newPriceLabel.isHidden = true
        }
        else
        {
            cell.offLabel.isHidden = false
            cell.newPriceLabel.isHidden = false
            cell.mainTimeLabel.isHidden = false
        }
        
        var image = ""
        if let nimage = good.offPrImage
        {
            if(nimage is NSNull)
            {
                image = "nedstark"
                cell.image.image = UIImage(named: image)
            }
            else
            {
                if(nimage.contains("http"))
                {
                    image = nimage as! String
                    cell.image.loadImageUsingCacheWithUrlString(urlString: image)
                }
                else
                {
                    image = "nedstark"
                    cell.image.image = UIImage(named: image)
                }
            }
        }
        else
        {
            image = "nedstark"
            cell.image.image = UIImage(named: image)
        }
        
        if(storeGoods.count - 1 == indexPath.row)
        {
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mvc = storyboard.instantiateViewController(withIdentifier: "GoodModal") as! GoodModal
        mvc.isModalInPopover = true
        mvc.modalTransitionStyle = .coverVertical
        mvc.good = storeGoods[indexPath.row]
        
        self.present(mvc, animated: true, completion: nil)
    }
    
    func GetImagesAndSet(stId:Int)
    {
        let soapMessage = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><ImagesInStore xmlns=\"http://BuyApp.ir/\"><stId>\(stId)</stId></ImagesInStore></soap:Body></soap:Envelope>"
        
        let soapLenth = String(soapMessage.characters.count)
        let theUrlString = Request.webServiceAddress
        let theURL = NSURL(string: theUrlString)
        let mutableR = NSMutableURLRequest(url: theURL! as URL)
        
        mutableR.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
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
                        let mainDict1 = mainDict2.object(forKey: "ImagesInStoreResponse") as! NSDictionary
                        let mainDict = mainDict1.object(forKey: "ImagesInStoreResult") as! NSDictionary
                        
                        if mainDict.count > 0{
                            
                            let mainD = NSDictionary(dictionary: mainDict as [NSObject : AnyObject])
                            var cont = mainD["text"] as? String
                            cont = "{ \"content\" : " + cont! + "}"
                            
                            let data = (cont)?.data(using: .utf8)!
                            
                            guard let _result = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : AnyObject] else{
                                
                                return
                            }
                            
                            if let _ads = _result["content"] as? [AnyObject]{
                                
                                self.sliderImagesURLS = [String]()
                                self.sliderImages = [Ad]()
                                for ad in _ads{
                                    
                                    if let actad = ad as? [String : AnyObject]{
                                        
                                        self.sliderImagesURLS.append(actad["imgUrl"] as! String)
                                    }
                                }
                                
                                DispatchQueue.main.async {
                                    
                                    if self.sliderImagesURLS.count == 0
                                    {
                                        self.slider1ContainerSupportImageView.isHidden = false
                                        self.scrollView.bringSubview(toFront: self.slider1ContainerSupportImageView)
                                    }
                                    else
                                    {
                                        self.sliderImagesURLS.insert(self.store.urlImage as! String, at: 0)
                                        self.slider1ContainerSupportImageView.isHidden = true
                                        self.sliderVc1.slider.sliderImages = self.sliderImagesURLS
                                        self.sliderVc1.pageControl.numberOfPages = self.sliderImagesURLS.count
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
            }
        }
        dataTask.resume()
    }
    
    func QueryOnDB(stId:Int)
    {
        let soapMessage = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GoodsInStore xmlns=\"http://BuyApp.ir/\"><stId>\(stId)</stId></GoodsInStore></soap:Body></soap:Envelope>"
        
        let soapLenth = String(soapMessage.characters.count)
        let theUrlString = Request.webServiceAddress
        let theURL = NSURL(string: theUrlString)
        let mutableR = NSMutableURLRequest(url: theURL! as URL)
        
        mutableR.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
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
                        let mainDict1 = mainDict2.object(forKey: "GoodsInStoreResponse") as! NSDictionary
                        let mainDict = mainDict1.object(forKey: "GoodsInStoreResult") as! NSDictionary
                        
                        if mainDict.count > 0{
                            
                            let mainD = NSDictionary(dictionary: mainDict as [NSObject : AnyObject])
                            var cont = mainD["text"] as? String
                            cont = "{ \"content\" : " + cont! + "}"
                            
                            let data = (cont)?.data(using: .utf8)!
                            
                            guard let _result = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : AnyObject] else{
                                
                                return
                            }
                            
                            if let _goods = _result["content"] as? [AnyObject]{
                                
                                
                                if _goods.count > 0
                                {
                                    self.storeGoods = [Good]()
                                }
                                for good in _goods{
                                    
                                    if let actgood = good as? [String : AnyObject]{
                                        
                                        let newgood = Good(Id: actgood["Id"]!, servicesId: actgood["servicesId"]!, offTitle: actgood["offTitle"]!, offPrImage: actgood["offPrImage"]!, offBeforePrice: actgood["offBeforePrice"]!, offPercent: actgood["offPercent"]!, offActive: actgood["offActive"]!, offDescription: actgood["offDescription"]!, offStartDate: actgood["offStartDate"]!, offEndDate: actgood["offEndDate"]!, offStartTime: actgood["offStartTime"]!, offEndTime: actgood["offEndTime"]!, Views: actgood["Views"]!)
                                        self.storeGoods.append(newgood)
                                        
                                    }
                                }
                                
                                DispatchQueue.main.async {
                                    
                                    self.collectionView.reloadData()
                                    if self.storeGoods.count > 0
                                    {
                                        let height = self.slider1Container.frame.height + self.followingButton.frame.height + 5 + self.containersContainer.frame.height + 5 + (4 * self.name.frame.height) + self.collectionView.frame.height + 8 + self.address.frame.height
                                        
                                        self.scrollView.contentSize = CGSize(self.view.frame.width , height)
                                    }
                                    else
                                    {
                                        let height = self.slider1Container.frame.height + self.followingButton.frame.height + 5 + self.containersContainer.frame.height + 5 + (4 * self.name.frame.height) + self.address.frame.height
                                        
                                        self.scrollView.contentSize = CGSize(self.view.frame.width , height)
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
            }
        }
        dataTask.resume()
    }
    
    
    func setFollow(stId:Int , userId: Int , saveUserId:Bool)
    {
        let soapMessage = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SetFollow xmlns=\"http://BuyApp.ir/\"><stId>\(stId)</stId><userId>\(userId)</userId></SetFollow></soap:Body></soap:Envelope>"
        
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
                        let mainDict1 = mainDict2.object(forKey: "SetFollowResponse") as! NSDictionary
                        let mainDict = mainDict1.object(forKey: "SetFollowResult") as! NSDictionary
                        
                        if mainDict.count > 0{
                            
                            let mainD = NSDictionary(dictionary: mainDict as [NSObject : AnyObject])
                            var cont = mainD["text"] as? String
                            cont = "{ \"content\" : " + cont! + "}"
                            
                            let data = (cont)?.data(using: .utf8)!
                            
                            guard let _result = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : AnyObject] else{
                                
                                return
                            }
                            
                            if let _res = _result["content"] as? [AnyObject]{
                                
                                for res in _res{
                                    
                                    if let actres = res as? [String : AnyObject]{
                                        
                                        if defaults.object(forKey: "follow\(self.store.Id!)") != nil //fellow already
                                        {
                                            DispatchQueue.main.async {
                                                
                                                self.followingButton.backgroundColor = UIColor(r: 35, g: 35, b: 35)
                                                defaults.removeObject(forKey: "follow\(self.store.Id!)") //unfollow
                                                self.store.Followers = ((self.store.Followers as! Int) - 1) as AnyObject
                                                self.followerLabel.text = "\(self.store.Followers!) دنبال کننده"
                                            }
                                        }
                                        else
                                        {
                                            DispatchQueue.main.async {
                                                
                                                self.followingButton.backgroundColor = UIColor(r: 0, g: 200, b: 0)
                                                defaults.set(self.store.Id, forKey: "follow\(self.store.Id!)") //set follow
                                                self.store.Followers = ((self.store.Followers as! Int) + 1) as AnyObject
                                                self.followerLabel.text = "\(self.store.Followers!) دنبال کننده"
                                            }
                                        }
                                        
                                        
                                        if saveUserId
                                        {
                                            defaults.set(actres["Id"] as! Int, forKey: "userId") //save user id once a time
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
            }
        }
        dataTask.resume()
    }
}
