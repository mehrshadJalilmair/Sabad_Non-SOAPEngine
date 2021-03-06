//
//  Goods.swift
//  Sabad
//
//  Created by Mehrshad Jalilmasir on 1/26/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit
import SCLAlertView

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
        button.backgroundColor = UIColor(r: 35, g: 35, b: 35)
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

        NotificationCenter.default.addObserver(self, selector: #selector(Update), name: NSNotification.Name(rawValue: "Update"), object: nil)
        
        //initSlider()
        initFilter()
        initCollectionView()
        QueryOnDB(twId: twId, MallId: self.MallId, stId: self.stId, srvTypeId: self.srvTypeId, Offset: self.Offset)
    }
    
    override func viewDidLayoutSubviews() {
        
        //add slider to container
        //self.sliderVc1!.view.frame = self.slider1Container.frame
    }
    
    func Update()
    {
        QueryOnDB(twId: twId, MallId: self.MallId, stId: self.stId, srvTypeId: self.srvTypeId, Offset: self.Offset)
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
            }
            .didCloseHandler { popup in

                
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
        
    }
    
    func QueryOnDB(twId:Int , MallId:Int , stId:Int, srvTypeId:Int , Offset:Int)
    {
        globalAlert.showWait("", subTitle: "لطفا صبور باشید...", closeButtonTitle: "", duration: 1000, colorStyle: 0x5065A1, colorTextButton: 0x000000, circleIconImage: nil, animationStyle: SCLAnimationStyle.bottomToTop)
        
        let soapMessage = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GoodByFilter xmlns=\"http://BuyApp.ir/\"><twId>\(twId)</twId><MallId>\(MallId)</MallId><stId>\(stId)</stId><srvTypeId>\(srvTypeId)</srvTypeId><Offset>\(Offset)</Offset></GoodByFilter></soap:Body></soap:Envelope>"
        
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
                        let mainDict1 = mainDict2.object(forKey: "GoodByFilterResponse") as! NSDictionary
                        let mainDict = mainDict1.object(forKey: "GoodByFilterResult") as! NSDictionary

                        
                        if mainDict.count > 0{
                            
                            let mainD = NSDictionary(dictionary: mainDict as [NSObject : AnyObject])
                            var cont = mainD["text"] as? String
                            cont = "{ \"content\" : " + cont! + "}"
                            
                            let data = (cont)?.data(using: .utf8)!
                            
                            guard let _result = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : AnyObject] else{
                                
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
                                
                                DispatchQueue.main.async {
                                    
                                    self.collectionView.reloadData()
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

    
    
    //collView funcs
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return goodsGoodList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GoodCell
        
        cell.topRightView.isHidden = true
        
        let good  = goodsGoodList[indexPath.row]
        
        cell.offLabel.text = "\(good.offPercent!) درصد    "
        cell.mainTimeLabel.text = "\(good.mainTime!) روز"
        cell.titleLabel.text = good.offTitle as! String?
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(good.offBeforePrice!) تومان")
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
        cell.alreadyPriceLabel.attributedText = attributeString
        
        let newPrice = (good.offBeforePrice as! Int)  - ((good.offBeforePrice as! Int) * (good.offPercent  as! Int) / 100)
        
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
            cell.mainTimeLabel.isHidden = false
            cell.newPriceLabel.isHidden = false
            cell.newPriceLabel.text = "\(newPrice) تومان"
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
        
        if(goodsGoodList.count - 1 == indexPath.row)
        {
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
