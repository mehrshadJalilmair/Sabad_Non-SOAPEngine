//
//  Home.swift
//  Sabad
//
//  Created by Mehrshad Jalilmasir on 1/28/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit
import AFNetworking

class Home: UIViewController , LIHSliderDelegate , UITableViewDataSource , UITableViewDelegate{

    let tableViewSectionsTitle:[String] = ["شلوغ ترین پاساژها" , "پرطرفدارترین فروشگاه ها" , "تازه ترین اجناس"]
    let numberOfSections = 3
    let tvCellId:String = "tvid"
    
    //slider (container + LIHSliderViewController)
    var slider1: LIHSlider!
    let slider1Container : UIView! = {
        
        let slider1Container = UIView()
        slider1Container.backgroundColor = UIColor.white
        slider1Container.translatesAutoresizingMaskIntoConstraints = false
        return slider1Container
    }()
    fileprivate var sliderVc1: LIHSliderViewController!
    
    //table view
    lazy var tableView : UITableView! =
        {
            let tableView : UITableView = UITableView(frame: self.view.frame)
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
            tableView.register(TopCollView.self, forCellReuseIdentifier: self.tvCellId)
            //tableView.backgroundColor = UIColor.red
            tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(Update), name: NSNotification.Name(rawValue: "Update"), object: nil)
        
        GetAdImagesAndSet(twId: twId)
        initSlider()
        configTableView()
        getHomeList(twId: twId)
    }
    
    func Update()
    {
        if changeBannerAndList
        {
            GetAdImagesAndSet(twId: twId)
            getHomeList(twId: twId)
            changeBannerAndList = false
        }
        else
        {
            GetAdImagesAndSet(twId: twId)
            getHomeList(twId: twId)
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if changeBannerAndList
        {
            GetAdImagesAndSet(twId: twId)
            getHomeList(twId: twId)
            changeBannerAndList = false
        }
    }
    
    override func viewDidLayoutSubviews() {
        
        //add slider to container
        self.sliderVc1!.view.frame = self.slider1Container.frame
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
        let images: [String] = ["" , ""]//["http://static2.varzesh3.com/v3/static/img/varzesh3-logo.png" , "http://static2.varzesh3.com/v3/static/img/varzesh3-logo.png" , "http://static2.varzesh3.com/v3/static/img/varzesh3-logo.png" , "http://static2.varzesh3.com/v3/static/img/varzesh3-logo.png"]
        slider1 = LIHSlider(images: images)
        //slider1.sliderDescriptions = ["Image 1 description","Image 2 description","Image 3 description","Image 4 description","Image 5 description","Image 6 description"]
        self.sliderVc1  = LIHSliderViewController(slider: slider1)
        sliderVc1.delegate = self
        self.addChildViewController(self.sliderVc1)
        self.view.addSubview(self.sliderVc1.view)
        self.sliderVc1.didMove(toParentViewController: self)
    }
    
    func configTableView()
    {
        view.addSubview(tableView)
        
        //x
        let horizontalConstraint = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //y
        let verticalConstraint = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: slider1Container, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //w
        let widthConstraint = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        let width = ((SCREEN_SIZE.width) / 2) - 10
        let height =  ((SCREEN_SIZE.width) / 2) + width/2 - 15
        let heightConstraint = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: SCREEN_SIZE.height - (self.tabBarController?.tabBar.frame.size.height)! - slider1Container.frame.size.height - height/1.57)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
}

extension Home
{
    //press image slider index
    func itemPressedAtIndex(index: Int) {
        
    }
    
    func GetAdImagesAndSet(twId:Int)
    {
        
        let soapMessage = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><AdvList xmlns=\"http://BuyApp.ir/\"><twId>\(twId)</twId></AdvList></soap:Body></soap:Envelope>"
        
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
                        let mainDict1 = mainDict2.object(forKey: "AdvListResponse") as! NSDictionary
                        let mainDict = mainDict1.object(forKey: "AdvListResult") as! NSDictionary
                        
     
                        
                        if mainDict.count > 0{
                            
                            let mainD = NSDictionary(dictionary: mainDict as [NSObject : AnyObject])
                            var cont = mainD["text"] as? String
                            cont = "{ \"content\" : " + cont! + "}"
                            
                            let data = (cont)?.data(using: .utf8)!
                            
                            guard let _result = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : AnyObject] else{
                                
                                return
                            }
                            
                            if let _ads = _result["content"] as? [AnyObject]{
                                
                                adsImages = [String]()
                                ads = [Ad]()
                                for ad in _ads{
                                    
                                    if let actad = ad as? [String : AnyObject]{
                                        
                                        
                                        let newAd = Ad(advImageUrl: actad["advImageUrl"]!, advText: actad["advText"]!, _Type: actad["Type"]!, Address: actad["Address"]!)
                                        ads.append(newAd)
                                        adsImages.append(actad["advImageUrl"] as! String)
                                    }
                                }
                                
                                if adsImages.count > 0
                                {
                                    self.sliderVc1.slider.sliderImages = adsImages
                                    self.sliderVc1.pageControl.numberOfPages = adsImages.count
                                }
                            }                        }
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
    
    
    func getHomeList(twId:Int)
    {
        let soapMessage = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetHomeList xmlns=\"http://BuyApp.ir/\"><twId>\(twId)</twId></GetHomeList></soap:Body></soap:Envelope>"
        
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
                        let mainDict1 = mainDict2.object(forKey: "GetHomeListResponse") as! NSDictionary
                        let mainDict = mainDict1.object(forKey: "GetHomeListResult") as! NSDictionary
                        
                        if mainDict.count > 0{
                            
                            let mainD = NSDictionary(dictionary: mainDict as [NSObject : AnyObject])
                            var cont = mainD["text"] as? String
                            cont = "{ \"content\" : " + cont! + "}"
                            
                            let data = (cont)?.data(using: .utf8)!
                            
                            guard let _result = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : AnyObject] else{
                                
                                return
                            }
                            
                            if let _results = _result["content"] as? [String : AnyObject]{
                                
                                
                                if let _malls = _results["MallList"] as? [AnyObject]{
                                    
                                    if _malls.count > 0
                                    {
                                        homeMallList = [Mall]()
                                    }
                                    for mall in _malls{
                                        
                                        if let actmall = mall as? [String : AnyObject]{
                                            
                                            let newmall = Mall(Id: actmall["Id"]!, twId: actmall["twId"]!, MallName: actmall["MallName"]!, MallDescription: actmall["MallDescription"]!, MallAddress: actmall["MallAddress"]!, MallTel: actmall["MallTel"]!, MallLogo: actmall["MallLogo"]!, MallActive: actmall["MallActive"]!, IsMall: actmall["IsMall"]!, Stores: actmall["Stores"]!)
                                            homeMallList.append(newmall)
                                        }
                                    }
                                }
                                
                                if let _stores = _results["StoreList"] as? [AnyObject]{
                                    
                                    homeStoreList = [Store]()
                                    
                                    for store in _stores{
                                        
                                        if let actstore = store as? [String : AnyObject]{
                                            
                                            let newstore = Store(Id: actstore["Id"]!, stCode: actstore["stCode"]!, MallId: actstore["MallId"]!, stName: actstore["stName"]!, stAddress: actstore["stAddress"]!, stManager: actstore["stManager"]!, stDescription: actstore["stDescription"]!, stTel: actstore["stTel"]!, stActive: actstore["stActive"]!, Mobile: actstore["Mobile"]!, urlImage: actstore["urlImage"]!, pm: actstore["pm"]!, Followers: actstore["Followers"]!)
                                            homeStoreList.append(newstore)
                                            
                                        }
                                    }
                                }
                                
                                if let _goods = _results["OffList"] as? [AnyObject]{
                                    
                                    homeGoodsList = [Good]()
                                    
                                    for good in _goods{
                                        
                                        if let actgood = good as? [String : AnyObject]{
                                            
                                            let newgood = Good(Id: actgood["Id"]!, servicesId: actgood["servicesId"]!, offTitle: actgood["offTitle"]!, offPrImage: actgood["offPrImage"]!, offBeforePrice: actgood["offBeforePrice"]!, offPercent: actgood["offPercent"]!, offActive: actgood["offActive"]!, offDescription: actgood["offDescription"]!, offStartDate: actgood["offStartDate"]!, offEndDate: actgood["offEndDate"]!, offStartTime: actgood["offStartTime"]!, offEndTime: actgood["offEndTime"]!, Views: actgood["Views"]!)
                                            homeGoodsList.append(newgood)
                                            
                                        }
                                    }
                                }
                                
                                DispatchQueue.main.async {
                                    
                                    self.tableView.reloadData()
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
        }
        dataTask.resume()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return numberOfSections
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 25
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(0, 0, tableView.frame.size.width, 25))
        let label = UILabel(frame: CGRect(0, 0, tableView.frame.size.width - 26, 25))
        let icon = UIButton(type: UIButtonType.system)
        icon.frame = CGRect(0, 0, 25, 25)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(icon)
        //x
        var horizontalConstraint = NSLayoutConstraint(item: icon, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: headerView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //y
        var verticalConstraint = NSLayoutConstraint(item: icon, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: headerView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //w
        var widthConstraint = NSLayoutConstraint(item: icon, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 25)
        //h
        var heightConstraint = NSLayoutConstraint(item: icon, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 25)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        
        headerView.addSubview(label)
        //x
        horizontalConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: icon, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: headerView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: headerView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: headerView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = UIFont(name: "American Typewriter" , size: 14)
        label.text = "   \(tableViewSectionsTitle[section])"
        
        icon.setImage(UIImage(named :"moreinfo"), for: UIControlState.normal)
        icon.addTarget(self, action: #selector(moreItemClicked(sender:)), for: UIControlEvents.touchUpInside)
        icon.tintColor = UIColor.black
        icon.tag = section
        
        headerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
        return headerView
    }
    func moreItemClicked(sender: UIButton)
    {
        moreInSearchType = sender.tag + 1
        tabBarView.barItemTapped(sender: tabBarView.tabBarButtons[1])
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return tableViewSectionsTitle[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let width = ((SCREEN_SIZE.width) / 2) - 10
        return ((SCREEN_SIZE.width) / 2) + width/2 - 15
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        let cell = tableView.dequeueReusableCell(withIdentifier: tvCellId, for: indexPath) as! TopCollView
        cell.type = indexPath.section
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
