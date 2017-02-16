//
//  Goods.swift
//  Sabad
//
//  Created by Mehrshad Jalilmasir on 1/26/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class Goods: UIViewController  , LIHSliderDelegate , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource{

    var getMoreGood = true

    var MallId:Int = -1
    var stId:Int = -1
    var Offset:Int = 0
    var srvTypeId:Int = 1
    
    //good cell id
    let cellId = "good"
    
    //slider (container + LIHSliderViewController)
    let slider1Container : UIView! = {
        
        let slider1Container = UIView()
        slider1Container.backgroundColor = UIColor.white
        slider1Container.translatesAutoresizingMaskIntoConstraints = false
        return slider1Container
    }()
    fileprivate var sliderVc1: LIHSliderViewController!
    
    //Filter Button container + Button
    let filterView : UIView! = {
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        return filterView
    }()
    lazy var filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("فیلتر", for: .normal)
        //button.setImage(UIImage(named: "ic_refresh"), for: .normal)
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        //button.semanticContentAttribute = .forceRightToLeft
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(filterGood), for: .touchUpInside)
        return button
    }()
    
    //collection view
    lazy var collectionView : UICollectionView! =
    {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
        let width = ((SCREEN_SIZE.width) / 2) - 10
        let height = ((SCREEN_SIZE.width) / 2) + width/2 - 15
        layout.itemSize = CGSize(width: width, height: height)
        
        let collectionView : UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GoodCell.self, forCellWithReuseIdentifier: self.cellId)
        collectionView.backgroundColor = UIColor.white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //initSlider()
        initFilter()
        initCollectionView()
        QueryOnDB(twId: twId, MallId: self.MallId, stId: self.stId, srvTypeId: self.srvTypeId, Offset: self.Offset)
    }
    
    override func viewDidLayoutSubviews() {
        
        //add slider to container
        //self.sliderVc1!.view.frame = self.slider1Container.frame
    }
    
    func initSlider()
    {
        //add slider container to view + autoLayouting
        view.addSubview(slider1Container)
        
        //x
        let horizontalConstraint = NSLayoutConstraint(item: slider1Container, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //y
        let verticalConstraint = NSLayoutConstraint(item: slider1Container, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //w
        let widthConstraint = NSLayoutConstraint(item: slider1Container, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        let heightConstraint = NSLayoutConstraint(item: slider1Container, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: SCREEN_SIZE.height/4)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        //init Slider One (Top)
        let images: [String] = ["http://static2.varzesh3.com/v3/static/img/varzesh3-logo.png" , "http://static2.varzesh3.com/v3/static/img/varzesh3-logo.png" , "http://static2.varzesh3.com/v3/static/img/varzesh3-logo.png" , "http://static2.varzesh3.com/v3/static/img/varzesh3-logo.png"]
        let slider1: LIHSlider = LIHSlider(images: images)
        //slider1.sliderDescriptions = ["Image 1 description","Image 2 description","Image 3 description","Image 4 description","Image 5 description","Image 6 description"]
        self.sliderVc1  = LIHSliderViewController(slider: slider1)
        sliderVc1.delegate = self
        self.addChildViewController(self.sliderVc1)
        self.view.addSubview(self.sliderVc1.view)
        self.sliderVc1.didMove(toParentViewController: self)
    }
    
    func initFilter()
    {
        view.addSubview(filterView)
        //x
        var horizontalConstraint = NSLayoutConstraint(item: filterView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 20)
        //y
        var verticalConstraint = NSLayoutConstraint(item: filterView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        var widthConstraint = NSLayoutConstraint(item: filterView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -10)
        //h
        var heightConstraint = NSLayoutConstraint(item: filterView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 25)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        filterView.addSubview(filterButton)
        //x
        horizontalConstraint = NSLayoutConstraint(item: filterButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: filterView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: filterButton, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: filterView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: filterButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: filterView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: filterButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 25)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func initCollectionView()
    {
        view.addSubview(collectionView)
        
        //x
        let horizontalConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //y
        let verticalConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: filterView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //w
        let widthConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        let heightConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: SCREEN_SIZE.height - (self.tabBarController?.tabBar.frame.size.height)! - 25 - 20)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
}

extension Goods
{
    func filterGood()
    {
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
                
                print(filterType)
                print(selectedMallId)
                print(selectedTownId)
                
                if isConfirmFiltering
                {
                    self.Offset = 0
                    self.QueryOnDB(twId: selectedTownId, MallId: selectedMallId, stId: -1, srvTypeId: filterType, Offset: self.Offset)
                }
            }
        
        let container = Filter.instance()
        container.closeHandler = { _ in
            popup.dismiss()
        }
        popup.show(container)
    }
    
    //press image slider index
    func itemPressedAtIndex(index: Int) {
        
        print("index \(index) is pressed")
    }
    
    //get from web service
    func QueryOnDB(twId:Int , MallId:Int , stId:Int, srvTypeId:Int , Offset:Int) //check out all conditions
    {
        let soap = SOAPEngine()
        soap.userAgent = "SOAPEngine"
        soap.actionNamespaceSlash = true
        soap.version = SOAPVersion.VERSION_1_1
        soap.responseHeader = true
        
        soap.setValue(twId, forKey: "twId")
        soap.setValue(MallId, forKey: "MallId")
        soap.setValue(stId, forKey: "stId")
        soap.setValue(srvTypeId, forKey: "srvTypeId")
        soap.setValue(Offset, forKey: "Offset")
        soap.requestURL(Request.webServiceAddress,
                        soapAction: Request.goodsFilteringAction,
                        completeWithDictionary: { (statusCode : Int,
                            dict : [AnyHashable : Any]?) -> Void in
                            
                            let result:Dictionary = dict! as Dictionary
                            //print(result)
                            let result1:NSDictionary = result[Array(result.keys)[0]]! as! NSDictionary
                            let result2:NSDictionary = result1["GoodByFilterResponse"] as! NSDictionary
                            var result3:String = result2["GoodByFilterResult"] as! String
                            
                            result3 = "{ \"content\" : " + result3 + "}"
                            let data = (result3).data(using: .utf8)!
                            
                            guard let _result = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : AnyObject] else{
                                
                                return
                            }
                            
                            if let _goods = _result["content"] as? [AnyObject]{
                                
                                Offset == 0 ? goodsGoodList = [Good]() : () //load more or not
                                
                                if _goods.count == 0
                                {
                                    self.getMoreGood = false
                                }
                                else
                                {
                                    self.getMoreGood = true
                                }
                                
                                for good in _goods{
                                    
                                    if let actgood = good as? [String : AnyObject]{
                                        
                                        let newgood = Good(Id: actgood["Id"]!, servicesId: actgood["servicesId"]!, offTitle: actgood["offTitle"]!, offPrImage: actgood["offPrImage"]!, offBeforePrice: actgood["offBeforePrice"]!, offPercent: actgood["offPercent"]!, offActive: actgood["offActive"]!, offDescription: actgood["offDescription"]!, offStartDate: actgood["offStartDate"]!, offEndDate: actgood["offEndDate"]!, offStartTime: actgood["offStartTime"]!, offEndTime: actgood["offEndTime"]!, Views: actgood["Views"]!)
                                        goodsGoodList.append(newgood)
                                        
                                    }
                                }
                                self.collectionView.reloadData()
                            }
                            
        }) { (error : Error?) -> Void in
            
            print(error!)
        }
    }

    
    //collView funcs
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return goodsGoodList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GoodCell
        
        cell.topRightView.isHidden = true
        
        let good  = goodsGoodList[indexPath.row]
        
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
        
        if(goodsGoodList.count - 1 == indexPath.row)
        {
            print("s4")
            DispatchQueue.main.async {
                
                if self.getMoreGood
                {
                    self.Offset = goodsGoodList.count
                    self.QueryOnDB(twId:twId , MallId:self.MallId , stId:self.stId, srvTypeId:self.srvTypeId , Offset:self.Offset)
                }
            }
        }
        
        return cell

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mvc = storyboard.instantiateViewController(withIdentifier: "GoodModal") as! GoodModal
        mvc.isModalInPopover = true
        mvc.modalTransitionStyle = .coverVertical
        mvc.good = goodsGoodList[indexPath.row]
        
        self.present(mvc, animated: true, completion: nil)
    }
}
