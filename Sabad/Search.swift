//
//  Search.swift
//  Sabad
//
//  Created by Mehrshad Jalilmasir on 1/27/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit
import SCLAlertView

class Search: UIViewController , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource , UITableViewDelegate , UITableViewDataSource , UIScrollViewDelegate , UITextFieldDelegate
{

    var tapGesture:UITapGestureRecognizer!
    
    var getMoreGood = true
    var getMoreStore = true
    var getMoreMall = true
    
    var lastContentOffset:CGFloat = 0.0
    var lastContentOffsetCache:CGFloat = 0.0
    
    var type:Int = 1
    var Offset:Int = 0
    var TxtSearch:String = ""
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    //good cell id
    let cellId1:String = "tabsearch"
    let cellId2:String = "collsearch"
    
    //collection view
    lazy var collectionView : UICollectionView! =
    {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
        let width = ((SCREEN_SIZE.width) / 2) - 10
        let height = ((SCREEN_SIZE.width) / 2) + width/2
        layout.itemSize = CGSize(width: width, height: height)
            
        let collectionView : UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GoodCell.self, forCellWithReuseIdentifier: self.cellId2)
        collectionView.backgroundColor = UIColor.white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.keyboardDismissMode = .onDrag
        return collectionView
    }()

    //table view
    lazy var tableView : UITableView! =
    {
        let tableView : UITableView = UITableView(frame: self.view.frame)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(SearchCell.self, forCellReuseIdentifier: self.cellId1)
        //tableView.backgroundColor = UIColor.red
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    //dialog view + buttons
    lazy var dialogView : UIView! =
    {
        let dV = UIView()//(frame: CGRect(0, 0, SCREEN_SIZE.width/2 + SCREEN_SIZE.width/4, 60))
        dV.backgroundColor = UIColor.lightGray
        dV.layer.cornerRadius = 10
        dV.clipsToBounds = true
        dV.translatesAutoresizingMaskIntoConstraints = false
        return dV
    }()
    lazy var inMallsButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 80/255, green: 101/255, blue: 161/255 , alpha: 1)
        button.setTitle("در پاساژ و محدوده ها", for: .normal)
        //button.setImage(UIImage(named: "ic_refresh"), for: .normal)
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = UIColor.white
        button.addTarget(self, action: #selector(mallSearchType), for: .touchUpInside)
        return button
    }()
    lazy var inStoresButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 80/255, green: 101/255, blue: 161/255 , alpha: 1)
        button.setTitle("در فروشگاه ها", for: .normal)
        //button.setImage(UIImage(named: "ic_refresh"), for: .normal)
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = UIColor.white
        button.addTarget(self, action: #selector(storeSearchType), for: .touchUpInside)
        return button
    }()
    lazy var inGoodButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 80/255, green: 101/255, blue: 161/255 , alpha: 1)
        button.setTitle("در کالاها", for: .normal)
        //button.setImage(UIImage(named: "ic_refresh"), for: .normal)
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = UIColor.white
        button.addTarget(self, action: #selector(goodSearchType), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(Update), name: NSNotification.Name(rawValue: "Update"), object: nil)
        
        searchText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        configDialog()
        configTableView()
        configCollectionView()
        self.collectionView.isHidden = true
        self.tableView.isHidden = true
        self.dialogView.isHidden = true
        QueryOnDB(type: self.type, TxtSearch: self.TxtSearch, Offset: self.Offset)
    }

    func Update()
    {
        
        if moreInSearchType > 0
        {
            self.type = moreInSearchType
            QueryOnDB(type: self.type, TxtSearch: self.TxtSearch, Offset: self.Offset)
            moreInSearchType = -1
        }
        else
        {
            QueryOnDB(type: self.type, TxtSearch: self.TxtSearch, Offset: self.Offset)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if moreInSearchType > 0
        {
            self.type = moreInSearchType
            QueryOnDB(type: self.type, TxtSearch: self.TxtSearch, Offset: self.Offset)
            moreInSearchType = -1
        }
    }
    
    func configCollectionView()
    {
        view.addSubview(collectionView)
        
        //x
        let horizontalConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //y
        let verticalConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: searchView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //w
        let widthConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        let heightConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: SCREEN_SIZE.height - (self.tabBarController?.tabBar.frame.size.height)! - searchView.frame.size.height)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func configTableView()
    {
        view.addSubview(tableView)
        
        //x
        let horizontalConstraint = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //y
        let verticalConstraint = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: searchView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //w
        let widthConstraint = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        let heightConstraint = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: SCREEN_SIZE.height - (self.tabBarController?.tabBar.frame.size.height)! - searchView.frame.size.height)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func configDialog()
    {
        view.addSubview(dialogView)
        
        //x
        var horizontalConstraint = NSLayoutConstraint(item: dialogView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //y
        var verticalConstraint = NSLayoutConstraint(item: dialogView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        //w
        var widthConstraint = NSLayoutConstraint(item: dialogView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: SCREEN_SIZE.width/2 + SCREEN_SIZE.width/4)
        //h
        var heightConstraint = NSLayoutConstraint(item: dialogView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: SCREEN_SIZE.height/4)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        dialogView.addSubview(inMallsButton)
        //x
        horizontalConstraint = NSLayoutConstraint(item: inMallsButton, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: dialogView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: inMallsButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: dialogView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: inMallsButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: dialogView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: inMallsButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: dialogView, attribute: NSLayoutAttribute.height, multiplier: 1/3, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        dialogView.addSubview(inStoresButton)
        //x
        horizontalConstraint = NSLayoutConstraint(item: inStoresButton, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: dialogView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: inStoresButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: inMallsButton, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: inStoresButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: dialogView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: inStoresButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: dialogView, attribute: NSLayoutAttribute.height, multiplier: 1/3, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        dialogView.addSubview(inGoodButton)
        //x
        horizontalConstraint = NSLayoutConstraint(item: inGoodButton, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: dialogView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: inGoodButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: inStoresButton, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: inGoodButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: dialogView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: inGoodButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: dialogView, attribute: NSLayoutAttribute.height, multiplier: 1/3, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func configuerTouchOutOfDialog()
    {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(TouchOutOfDialog))
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
    }
}

extension Search
{
    func textFieldDidChange(_ textField: UITextField)
    {
        if textField.text! == "" {
            
            QueryOnDB(type: 1, TxtSearch: "" , Offset: 0)
        }
    }
    
    @IBAction func doSearch(_ sender: Any) {
        
        configuerTouchOutOfDialog()
        self.dialogView.isHidden = false
        self.view.bringSubview(toFront: self.dialogView)
    }
    
    //search dialog funcs
    func mallSearchType()
    {
        self.view.removeGestureRecognizer(self.tapGesture)
        type = 1
        self.Offset = 0
        self.TxtSearch = searchText.text!
        self.dialogView.isHidden = true
        QueryOnDB(type: self.type, TxtSearch: self.TxtSearch, Offset: self.Offset)
    }
    func storeSearchType()
    {
        self.view.removeGestureRecognizer(self.tapGesture)
        type = 2
        self.Offset = 0
        self.TxtSearch = searchText.text!
        self.dialogView.isHidden = true
        QueryOnDB(type: self.type, TxtSearch: self.TxtSearch, Offset: self.Offset)
    }
    func goodSearchType()
    {
        self.view.removeGestureRecognizer(self.tapGesture)
        type = 3
        self.Offset = 0
        self.TxtSearch = searchText.text!
        self.dialogView.isHidden = true
        QueryOnDB(type: self.type, TxtSearch: self.TxtSearch, Offset: self.Offset)
    }
    func TouchOutOfDialog()
    {
        dialogView.isHidden = true
        self.view.removeGestureRecognizer(self.tapGesture)
    }
    
    func QueryOnDB(type:Int , TxtSearch:String , Offset:Int)
    {
        globalAlert.showWait("", subTitle: "لطفا صبور باشید...", closeButtonTitle: "", duration: 1000, colorStyle: 0x5065A1, colorTextButton: 0x000000, circleIconImage: nil, animationStyle: SCLAnimationStyle.bottomToTop)
        
        var TxtSearch:String = TxtSearch.replacingOccurrences(of: "ك", with: "ک")
        TxtSearch = TxtSearch.replacingOccurrences(of: "ي", with: "ی")
        
        let soapMessage = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><Search xmlns=\"http://BuyApp.ir/\"><Offset>\(Offset)</Offset><text>\(TxtSearch)</text><type>\(type)</type><twId>\(twId)</twId></Search></soap:Body></soap:Envelope>"
        
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
                        let mainDict1 = mainDict2.object(forKey: "SearchResponse") as! NSDictionary
                        let mainDict = mainDict1.object(forKey: "SearchResult") as! NSDictionary

                        
                        if mainDict.count > 0{
                            
                            let mainD = NSDictionary(dictionary: mainDict as [NSObject : AnyObject])
                            var cont = mainD["text"] as? String
                            cont = "{ \"content\" : " + cont! + "}"
                            
                            let data = (cont)?.data(using: .utf8)!
                            
                            guard let _result = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : AnyObject] else{
                                
                                return
                            }
                            
                            if(type == 1)
                            {
                                if let _malls = _result["content"] as? [AnyObject]{
                                    
                                    Offset == 0 ? searchMallList = [Mall]() : () //load more or not
                                    
                                    if _malls.count == 0
                                    {
                                        self.getMoreMall = false
                                    }
                                    else
                                    {
                                        self.getMoreMall = true
                                    }
                                    
                                    for mall in _malls{
                                        
                                        if let actmall = mall as? [String : AnyObject]{
                                            
                                            let newmall = Mall(Id: actmall["Id"]!, twId: actmall["twId"]!, MallName: actmall["MallName"]!, MallDescription: actmall["MallDescription"]!, MallAddress: actmall["MallAddress"]!, MallTel: actmall["MallTel"]!, MallLogo: actmall["MallLogo"]!, MallActive: actmall["MallActive"]!, IsMall: actmall["IsMall"]! , Stores: actmall["Stores"]! as AnyObject)
                                            searchMallList.append(newmall)
                                        }
                                    }
                                    
                                    DispatchQueue.main.async {
                                        
                                        
                                        self.collectionView.isHidden = true
                                        self.tableView.isHidden = false
                                        self.tableView.reloadData()
                                    }
                                }
                                
                            }
                            else if(type == 2)
                            {
                                if let _stores = _result["content"] as? [AnyObject]{
                                    
                                    Offset == 0 ? searchStoreList = [Store]() : () //load more or not
                                    
                                    if _stores.count == 0
                                    {
                                        self.getMoreStore = false
                                    }
                                    else
                                    {
                                        self.getMoreStore = true
                                    }
                                    
                                    for store in _stores{
                                        
                                        if let actstore = store as? [String : AnyObject]{
                                            
                                            let newstore = Store(Id: actstore["Id"]!, stCode: actstore["stCode"]!, MallId: actstore["MallId"]!, stName: actstore["stName"]!, stAddress: actstore["stAddress"]!, stManager: actstore["stManager"]!, stDescription: actstore["stDescription"]!, stTel: actstore["stTel"]!, stActive: actstore["stActive"]!, Mobile: actstore["Mobile"]!, urlImage: actstore["urlImage"]!, pm: actstore["pm"]!, Followers: actstore["Followers"]!)
                                            searchStoreList.append(newstore)
                                            
                                        }
                                    }
                                    
                                    DispatchQueue.main.async {
                                        
                                        self.collectionView.isHidden = true
                                        self.tableView.isHidden = false
                                        self.tableView.reloadData()
                                    }
                                }
                                
                            }
                            else if(type == 3)
                            {
                                if let _goods = _result["content"] as? [AnyObject]{
                                    
                                    Offset == 0 ? searchGoodList = [Good]() : () //load more or not
                                    
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
                                            searchGoodList.append(newgood)
                                            
                                        }
                                    }
                                    
                                    DispatchQueue.main.async {
                                        
                                        self.collectionView.isHidden = false
                                        self.tableView.isHidden = true
                                        self.collectionView.reloadData()
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
            
            DispatchQueue.main.async {
                
                globalAlert.hideView()
            }
        }
        dataTask.resume()
    }

    //collView funcs
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return searchGoodList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId2, for: indexPath) as! GoodCell
        
        cell.topRightView.isHidden = true
        
        let good  = searchGoodList[indexPath.row]
        
        
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

        if(searchGoodList.count - 1 == indexPath.row)
        {
            DispatchQueue.main.async {
                
                if self.getMoreGood
                {
                    self.Offset = searchGoodList.count
                    self.QueryOnDB(type: self.type, TxtSearch: self.TxtSearch, Offset: self.Offset)
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
        mvc.good = searchGoodList[indexPath.row]
        
        self.present(mvc, animated: true, completion: nil)
    }

    //tableView funcs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if type == 3 {
            
            
        }else if(type == 2)
        {
            return searchStoreList.count
        }else if(type == 1)
        {
            return searchMallList.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId1, for: indexPath) as! SearchCell
        
        var image = ""
        var name = ""
        var tell = ""
        var address = ""
        var imageType = 0
        
        if(type == 1)
        {
            if let nimage = searchMallList[indexPath.row].MallLogo
            {
                if(nimage is NSNull)
                {
                    image = "nedstark"
                }
                else
                {
                    if(nimage.contains("http"))
                    {
                        image = nimage as! String
                        imageType = 1
                    }
                    else
                    {
                        image = "nedstark"
                    }
                }
            }
            else
            {
                image = "nedstark"
            }
            name = searchMallList[indexPath.row].MallName! as! String
            tell = searchMallList[indexPath.row].MallTel! as! String
            address = searchMallList[indexPath.row].MallAddress! as! String
        }
        else if(type == 2)
        {
            if let nimage = searchStoreList[indexPath.row].urlImage
            {
                if(nimage is NSNull)
                {
                    image = "nedstark"
                }
                else
                {
                    if(nimage.contains("http"))
                    {
                        image = nimage as! String
                        imageType = 1
                    }
                    else
                    {
                        image = "nedstark"
                    }
                }
            }
            else
            {
                image = "nedstark"
            }
            name = searchStoreList[indexPath.row].stName! as! String
            tell = searchStoreList[indexPath.row].stTel! as! String
            address = searchStoreList[indexPath.row].stAddress! as! String
        }

        if(imageType == 0)
        {
            cell.cimage.image = UIImage(named: image)
        }
        else
        {
            cell.cimage.loadImageUsingCacheWithUrlString(urlString: image)
        }
        cell.nameLabel.text = name
        cell.tellLabel.text = tell
        cell.addLabel.text = address
        
        if type == 1 {
            
            if(searchMallList.count - 1 == indexPath.row)
            {
                DispatchQueue.main.async {
                    
                    if self.getMoreMall
                    {
                        self.Offset = searchMallList.count
                        self.QueryOnDB(type: self.type, TxtSearch: self.TxtSearch, Offset: self.Offset)
                    }
                }
            }
        }
        else if type == 2
        {
            
            if(searchStoreList.count - 1 == indexPath.row)
            {
                DispatchQueue.main.async {
                    
                    if self.getMoreStore
                    {
                        self.Offset = searchStoreList.count
                        self.QueryOnDB(type: self.type, TxtSearch: self.TxtSearch, Offset: self.Offset)
                    }
                }
            }
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch type {
            
        case 2:
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mvc = storyboard.instantiateViewController(withIdentifier: "StoreModal") as! StoreModal
            mvc.isModalInPopover = true
            mvc.modalTransitionStyle = .coverVertical
            mvc.store = searchStoreList[indexPath.row]
            
            self.present(mvc, animated: true, completion: nil)
            
        case 1:
            
            let stores = searchMallList[indexPath.row].Stores as! Int
            if stores <= 0
            {
                return
            }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mvc = storyboard.instantiateViewController(withIdentifier: "MallModal") as! MallModal
            mvc.mall = searchMallList[indexPath.row]
            mvc.isModalInPopover = true
            mvc.modalTransitionStyle = .coverVertical
            
            storesInMall = [Store]()
            self.present(mvc, animated: true, completion: nil)
            
            break
        default:
            
            break
        }
    }
}
