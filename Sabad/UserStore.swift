//
//  UserStore.swift
//  Sabad
//
//  Created by Mehrshad JM on 3/8/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//


import UIKit

class UserStore: UIViewController , UIScrollViewDelegate , LIHSliderDelegate , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    let cellId = "Item"
    
    //views
    
    @IBOutlet var btnsView: UIView!
    @IBOutlet var addGoodBtn: UIButton!
    @IBOutlet var editBtn: UIButton!
    @IBOutlet var addOff: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topView: UIView!
    
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
    
    let containersContainer : UIView! = {
        
        let containersContainer = UIView()
        containersContainer.backgroundColor = UIColor.white
        containersContainer.translatesAutoresizingMaskIntoConstraints = false
        return containersContainer
    }()
    
    let followersCountContainer : UIView! = {
        
        let followersCountContainer = UIView()
        followersCountContainer.translatesAutoresizingMaskIntoConstraints = false
        followersCountContainer.isHidden = true
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
    
    let abuseContainer : UIView! = { //instead off delete
        
        let abuseContainer = UIView()
        abuseContainer.translatesAutoresizingMaskIntoConstraints = false
        return abuseContainer
    }()
    lazy var abuseLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.text = "حذف فروشگاه"
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
    
    func initSlider()
    {
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
        scrollView.addSubview(containersContainer)
        //x
        var horizontalConstraint = NSLayoutConstraint(item: containersContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: slider1Container, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        var verticalConstraint = NSLayoutConstraint(item: containersContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        var widthConstraint = NSLayoutConstraint(item: containersContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        var heightConstraint = NSLayoutConstraint(item: containersContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 30)
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
        
        
        btnsView.backgroundColor = UIColor.darkGray
        editBtn.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        editBtn.tintColor = UIColor.white
        editBtn.layer.cornerRadius = 1
        editBtn.layer.masksToBounds = true

        addOff.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        addOff.tintColor = UIColor.white
        addOff.layer.cornerRadius = 1
        addOff.layer.masksToBounds = true
        
        addGoodBtn.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        addGoodBtn.tintColor = UIColor.white
        addGoodBtn.layer.cornerRadius = 1
        addGoodBtn.layer.masksToBounds = true
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
        
        collectionView.backgroundColor = UIColor.white
    }
    
    @IBOutlet var dismiss: UIButton!
}

extension UserStore
{
    //press image slider index
    func itemPressedAtIndex(index: Int) {
        
        print(index)
    }
    
    @IBAction func edit(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mvc = storyboard.instantiateViewController(withIdentifier: "UpdateStore") as! UpdateStore
        mvc.isModalInPopover = true
        mvc.modalTransitionStyle = .coverVertical
        mvc.store = self.store
        mvc.ImagesURLS = self.sliderImagesURLS
        self.present(mvc, animated: true, completion: nil)
    }
    
    @IBAction func addOff(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mvc = storyboard.instantiateViewController(withIdentifier: "addOff") as! addOff
        mvc.isModalInPopover = true
        mvc.modalTransitionStyle = .coverVertical
        mvc.store = self.store
        self.present(mvc, animated: true, completion: nil)
    }
    
    @IBAction func addGood(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mvc = storyboard.instantiateViewController(withIdentifier: "addGood") as! addGood
        mvc.isModalInPopover = true
        mvc.modalTransitionStyle = .coverVertical
        mvc.store = self.store
        self.present(mvc, animated: true, completion: nil)
    }
    
    func setAbuse()
    {
        let alert = UIAlertController(title: "", message: "فروشگاه حذف شود؟", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "بله", style: UIAlertActionStyle.default, handler: { action in
            switch action.style{
            case .default:
                
                print("default")
                self.deleteStore()
                break
                
            case .cancel:
                
                print("cancel")
                break
                
            case .destructive:
                
                print("destructive")
                break
            }
        }))
        
        alert.addAction(UIAlertAction(title: "خیر", style: UIAlertActionStyle.cancel, handler: { action in
            switch action.style{
            case .default:
                
                print("default")
                break
                
            case .cancel:
                
                print("cancel")
                break
                
            case .destructive:
                
                print("destructive")
                break
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteStore()
    {
        
    }
    
    @IBAction func dismiss_(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
            print("dismiss")
        }
    }

    //collView funcs
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return storeGoods.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GoodCell
        
        let good  = self.storeGoods[indexPath.row]
        
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
        
        let good  = self.storeGoods[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mvc = storyboard.instantiateViewController(withIdentifier: "StoreGoodModal") as! StoreGoodModal
        mvc.isModalInPopover = true
        mvc.modalTransitionStyle = .coverVertical
        mvc.good = good
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
        mutableR.addValue("text/html; charset=utf-8", forHTTPHeaderField: "Content-Type")
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
                                        //self.slider1Container.isHidden = false
                                        
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
    
    func QueryOnDB(stId:Int)
    {
        let soapMessage = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GoodsInStore xmlns=\"http://BuyApp.ir/\"><stId>\(stId)</stId></GoodsInStore></soap:Body></soap:Envelope>"
        
        let soapLenth = String(soapMessage.characters.count)
        let theUrlString = Request.webServiceAddress
        let theURL = NSURL(string: theUrlString)
        let mutableR = NSMutableURLRequest(url: theURL! as URL)
        
        mutableR.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        mutableR.addValue("text/html; charset=utf-8", forHTTPHeaderField: "Content-Type")
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
                                        let height = self.slider1Container.frame.height  + self.containersContainer.frame.height + 5 + (4 * self.name.frame.height) + self.collectionView.frame.height + 8
                                        
                                        self.scrollView.contentSize = CGSize(self.view.frame.width , height)
                                    }
                                    else
                                    {
                                        let height = self.slider1Container.frame.height + self.containersContainer.frame.height + 5 + (4 * self.name.frame.height)
                                        
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
