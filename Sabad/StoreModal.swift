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
            return collectionView
    }()
    let collectionViewSupporterLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
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
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let manager: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let tell: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let desc: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var followingButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("پیگیری", for: .normal)
        //button.setImage(UIImage(named: "ic_refresh"), for: .normal)
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 2
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
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
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.backgroundColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var followerIcon:UIButton! = {
        
        let followerIcon = UIButton(type: .system)
        followerIcon.setImage(UIImage(named :"ic_refresh"), for: UIControlState.normal)
        //followerIcon.addTarget(self, action: #selector(setAbusesetAbuse), for: UIControlEvents.touchUpInside)
        followerIcon.translatesAutoresizingMaskIntoConstraints = false
        followerIcon.backgroundColor = UIColor.lightGray
        followerIcon.isUserInteractionEnabled = false
        followerIcon.tag = self.store.Id as! Int
        return followerIcon
    }()
    
    let abuseContainer : UIView! = {
        
        let abuseContainer = UIView()
        abuseContainer.translatesAutoresizingMaskIntoConstraints = false
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
        label.tag = self.store.Id as! Int
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
        icon.tag = self.store.Id as! Int
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
            followingButton.backgroundColor = UIColor(r: 80, g: 101, b: 161)
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
        
        //init Slider One (Top)
        //let images: [String] = ["" , ""]//["http://static2.varzesh3.com/v3/static/img/varzesh3-logo.png" , "http://static2.varzesh3.com/v3/static/img/varzesh3-logo.png" , "http://static2.varzesh3.com/v3/static/img/varzesh3-logo.png" , "http://static2.varzesh3.com/v3/static/img/varzesh3-logo.png"]
        slider1 = LIHSlider(images: sliderImagesURLS)
        //slider1.sliderDescriptions = ["Image 1 description","Image 2 description","Image 3 description","Image 4 description","Image 5 description","Image 6 description"]
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
    }
    
    func initCollectionView()
    {
        scrollView.addSubview(collectionView)
        let width = ((SCREEN_SIZE.width) / 2) - 10
        let height = ((SCREEN_SIZE.width) / 2) + width/2 - 20
        
        //x
        let horizontalConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //y
        let verticalConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.desc, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +8)
        //w
        let widthConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        let heightConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: height + 2)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        /*scrollView.addSubview(collectionViewSupporterLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: collectionViewSupporterLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: collectionViewSupporterLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.desc, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: collectionViewSupporterLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: collectionViewSupporterLabel, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])*/
        
        collectionView.backgroundColor = UIColor.white
        //collectionViewSupporterLabel.isHidden = false
        //scrollView.bringSubview(toFront: collectionViewSupporterLabel)
    }
}

extension StoreModal
{
    //press image slider index
    func itemPressedAtIndex(index: Int) {
        
        print(index)
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
    
    @IBAction func dismidd(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
            print("dismiss")
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
                    
                    print("call")
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
        
        cell.iconInTopRightView.image = UIImage(named: "ic_refresh")
        cell.labelInTopRightView.text =  "\(good.Views!) بازدید"
        
        if ((good.offPercent as! Int == 0) || (good.mainTime! < 0))
        {
            cell.offLabel.isHidden = true
            cell.mainTimeLabel.isHidden = true
        }
        else
        {
            cell.offLabel.isHidden = false
            cell.mainTimeLabel.isHidden = false
        }
        
        cell.offLabel.text = "\(good.offPercent!) درصد    "
        cell.mainTimeLabel.text = "\(good.mainTime!) روز"
        cell.titleLabel.text = good.offTitle as! String?
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(good.offBeforePrice!)")
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
        cell.alreadyPriceLabel.attributedText = attributeString
        
        let newPrice = (good.offBeforePrice as! Int)  - ((good.offBeforePrice as! Int) * (good.offPercent  as! Int) / 100)
        cell.newPriceLabel.text = "\(newPrice)"
        
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
            print("s02")
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
    
    //get from web service
    func GetImagesAndSet(stId:Int) //check out all conditions
    {
        let soap = SOAPEngine()
        soap.userAgent = "SOAPEngine"
        soap.actionNamespaceSlash = true
        soap.version = SOAPVersion.VERSION_1_1
        soap.responseHeader = true
        
        soap.setValue(stId, forKey: "stId")
        soap.requestURL(Request.webServiceAddress,
                        soapAction: Request.getStoreImagesAction,
                        completeWithDictionary: { (statusCode : Int,
                            dict : [AnyHashable : Any]?) -> Void in
                            
                            let result:Dictionary = dict! as Dictionary
                            //print(result)
                            let result1:NSDictionary = result[Array(result.keys)[0]]! as! NSDictionary
                            let result2:NSDictionary = result1["ImagesInStoreResponse"] as! NSDictionary
                            var result3:String = result2["ImagesInStoreResult"] as! String
                            
                            result3 = "{ \"content\" : " + result3 + "}"
                            //print(result3)
                            let data = (result3).data(using: .utf8)!
                            
                            guard let _result = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : AnyObject] else{
                                
                                return
                            }
                            
                            if let _ads = _result["content"] as? [AnyObject]{
                                
                                self.sliderImagesURLS = [String]()
                                self.sliderImages = [Ad]()
                                for ad in _ads{
                                    
                                    if let actad = ad as? [String : AnyObject]{
                                        
                                        
                                        //let newAd = Ad(advImageUrl: actad["advImageUrl"]!, advText: actad["advText"]!, _Type: actad["Type"]!, Address: actad["Address"]!)
                                        //self.sliderImages.append(newAd)
                                        self.sliderImagesURLS.append(actad["imgUrl"] as! String)
                                    }
                                }
                                if self.sliderImagesURLS.count == 0
                                {
                                    self.slider1ContainerSupportImageView.isHidden = false
                                    self.scrollView.bringSubview(toFront: self.slider1ContainerSupportImageView)
                                }
                                else
                                {
                                    //self.slider1Container.isHidden = false
                            
                                    self.sliderImagesURLS.insert(self.store.urlImage as! String, at: 0)
                                    self.slider1ContainerSupportImageView.isHidden = true
                                    self.sliderVc1.slider.sliderImages = self.sliderImagesURLS
                                    self.sliderVc1.pageControl.numberOfPages = self.sliderImagesURLS.count
                                }
                            }
                            
        }) { (error : Error?) -> Void in
            
            print(error!)
        }
    }
    
    //get from web service
    func QueryOnDB(stId:Int) //check out all conditions
    {
        let soap = SOAPEngine()
        soap.userAgent = "SOAPEngine"
        soap.actionNamespaceSlash = true
        soap.version = SOAPVersion.VERSION_1_1
        soap.responseHeader = true
        
        soap.setValue(stId, forKey: "stId")
        soap.requestURL(Request.webServiceAddress,
                        soapAction: Request.getStoreGoodsAction,
                        completeWithDictionary: { (statusCode : Int,
                            dict : [AnyHashable : Any]?) -> Void in
                            
                            let result:Dictionary = dict! as Dictionary
                            //print(result)
                            let result1:NSDictionary = result[Array(result.keys)[0]]! as! NSDictionary
                            let result2:NSDictionary = result1["GoodsInStoreResponse"] as! NSDictionary
                            var result3:String = result2["GoodsInStoreResult"] as! String
                            
                            result3 = "{ \"content\" : " + result3 + "}"
                            //print(result3)
                            let data = (result3).data(using: .utf8)!
                            
                            guard let _result = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : AnyObject] else{
                                
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
                                self.collectionView.reloadData()
                                if self.storeGoods.count > 0
                                {
                                    let height = self.slider1Container.frame.height + self.followingButton.frame.height + 5 + self.containersContainer.frame.height + 5 + (4 * self.name.frame.height) + self.collectionView.frame.height + 8
                                    
                                    self.scrollView.contentSize = CGSize(self.view.frame.width , height)
                                    //self.collectionViewSupporterLabel.isHidden = true
                                }
                                else
                                {
                                    let height = self.slider1Container.frame.height + self.followingButton.frame.height + 5 + self.containersContainer.frame.height + 5 + (4 * self.name.frame.height)
                                    
                                    self.scrollView.contentSize = CGSize(self.view.frame.width , height)
                                    
                                    //self.collectionViewSupporterLabel.isHidden = false
                                    //self.scrollView.bringSubview(toFront: self.collectionViewSupporterLabel)
                                }
                            }
                            
        }) { (error : Error?) -> Void in
            
            print(error!)
        }
    }
    
    //get from web service
    func setFollow(stId:Int , userId: Int , saveUserId:Bool) //check out all conditions
    {
        let soap = SOAPEngine()
        soap.userAgent = "SOAPEngine"
        soap.actionNamespaceSlash = true
        soap.version = SOAPVersion.VERSION_1_1
        soap.responseHeader = true
        
        soap.setValue(stId, forKey: "stId")
        soap.setValue(userId, forKey: "userId")
        soap.requestURL(Request.webServiceAddress,
                        soapAction: Request.setFollowAction,
                        completeWithDictionary: { (statusCode : Int,
                            dict : [AnyHashable : Any]?) -> Void in
                            
                            let result:Dictionary = dict! as Dictionary
                            //print(result)
                            let result1:NSDictionary = result[Array(result.keys)[0]]! as! NSDictionary
                            let result2:NSDictionary = result1["SetFollowResponse"] as! NSDictionary
                            var result3:String = result2["SetFollowResult"] as! String
                            
                            result3 = "{ \"content\" : " + result3 + "}"
                            //print(result3)
                            
                            let data = (result3).data(using: .utf8)!
                            
                            guard let _result = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : AnyObject] else{
                                
                                return
                            }
                            
                            if let _res = _result["content"] as? [AnyObject]{
                                
                                for res in _res{
                                    
                                    if let actres = res as? [String : AnyObject]{
                                        
                                        //print(actres["Id"]!)
                                    
                                        if defaults.object(forKey: "follow\(self.store.Id!)") != nil //fellow already
                                        {
                                            self.followingButton.backgroundColor = UIColor(r: 80, g: 101, b: 161)
                                            defaults.removeObject(forKey: "follow\(self.store.Id!)") //unfollow
                                            self.store.Followers = ((self.store.Followers as! Int) - 1) as AnyObject
                                            self.followerLabel.text = "\(self.store.Followers!) دنبال کننده"
                                            //self.store.Followers = ((self.store.Followers as! Int) - 1) as AnyObject
                                            //followerLabel.text = "\(self.store.Followers!) دنبال کننده"
                                        }
                                        else
                                        {
                                            self.followingButton.backgroundColor = UIColor(r: 0, g: 200, b: 0)
                                            defaults.set(self.store.Id, forKey: "follow\(self.store.Id!)") //set follow
                                            self.store.Followers = ((self.store.Followers as! Int) + 1) as AnyObject
                                            self.followerLabel.text = "\(self.store.Followers!) دنبال کننده"
                                        }
                                        
                                        
                                        if saveUserId
                                        {
                                            defaults.set(actres["Id"] as! Int, forKey: "userId") //save user id once a time
                                        }
                                    }
                                }
                            }
                            
        }) { (error : Error?) -> Void in
            
            print(error!)
        }
    }
}
