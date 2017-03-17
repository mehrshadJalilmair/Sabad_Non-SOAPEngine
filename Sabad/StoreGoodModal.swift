//
//  StoreGoodModal.swift
//  Sabad
//
//  Created by Mehrshad JM on 3/10/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit
import SCLAlertView

class StoreGoodModal: UIViewController {
    
    //views
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet var btnsView: UIView!
    
    @IBOutlet var editGoodBtn: UIButton!
    @IBOutlet var deleteGoodBtn: UIButton!
    
    let Image : UIImageView! = {
        
        let Image = UIImageView()
        Image.translatesAutoresizingMaskIntoConstraints = false
        return Image
    }()
    
    let offLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.backgroundColor = UIColor(r: 0, g: 200, b: 0)
        label.layer.cornerRadius = 2
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let offTitleLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.backgroundColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let offMainTimeLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.backgroundColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceContainer : UIView! = {
        
        let abuseContainer = UIView()
        abuseContainer.translatesAutoresizingMaskIntoConstraints = false
        abuseContainer.backgroundColor = UIColor.white
        return abuseContainer
    }()
    let AlPriceLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "قیمت قبلی"
        //label.backgroundColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let AlPriceNumberLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.lightGray
        label.textAlignment = .right
        //label.backgroundColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let newPriceLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "قیمت جدید"
        //label.backgroundColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let newPriceNumberLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.textAlignment = .right
        //label.backgroundColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //vars
    var haveOff = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        haveOff = true
        if ((selectedGood.offPercent as! Int == 0) || (selectedGood.mainTime! < 0))
        {
            haveOff = false
        }
        initViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        myInit()
    }
    
    func myInit()
    {
        offLabel.text = "\(selectedGood.offPercent!) درصد تخفیف"
        if !haveOff
        {
            offLabel.isHidden = true
        }
        else
        {
            offLabel.isHidden = false
        }
        offTitleLabel.text = "\(selectedGood.offTitle!)"
        offMainTimeLabel.text = "\(selectedGood.mainTime!) روز دیگر"
        if !haveOff
        {
            offMainTimeLabel.isHidden = true
        }
        else
        {
            offMainTimeLabel.isHidden = false
        }
        
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(selectedGood.offBeforePrice!) تومان")
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
        
        var newPrice = (selectedGood.offBeforePrice as! Int)
        if haveOff {
            
            newPrice = (selectedGood.offBeforePrice as! Int)  - ((selectedGood.offBeforePrice as! Int) * (selectedGood.offPercent  as! Int) / 100)
        }
        
        if haveOff {
            
            AlPriceNumberLabel.attributedText = attributeString
        }
        else
        {
            AlPriceLabel.text = "قیمت    "
            AlPriceNumberLabel.text =  "\(selectedGood.offBeforePrice!) تومان"
        }
        
        newPriceNumberLabel.text = "\(newPrice) تومان"
        if !haveOff
        {
            newPriceNumberLabel.isHidden = true
            newPriceLabel.isHidden = true
        }
        
        Image.loadImageUsingCacheWithUrlString(urlString: selectedGood.offPrImage as! String)
    }
    
    override func viewDidLayoutSubviews() {
        
        var height:CGFloat!
        
        if haveOff {
            
            height = (self.Image.frame.height + self.offTitleLabel.frame.height + self.offMainTimeLabel.frame.height + 10.0 + self.priceContainer.frame.height + self.btnsView.frame.height)
        }
        else
        {
            height = (self.Image.frame.height + self.offTitleLabel.frame.height +  10.0 + self.priceContainer.frame.height + self.btnsView.frame.height)
        }
        
        self.scrollView.contentSize = CGSize(self.view.frame.width , height)
    }
    
    func initViews()
    {
        btnsView.backgroundColor = UIColor.darkGray
        
        editGoodBtn.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        editGoodBtn.tintColor = UIColor.white
        editGoodBtn.layer.cornerRadius = 1
        editGoodBtn.layer.masksToBounds = true
        
        deleteGoodBtn.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        deleteGoodBtn.tintColor = UIColor.white
        deleteGoodBtn.layer.cornerRadius = 1
        deleteGoodBtn.layer.masksToBounds = true
        
        scrollView.addSubview(Image)
        //x
        var horizontalConstraint = NSLayoutConstraint(item: Image, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //y
        var verticalConstraint = NSLayoutConstraint(item: Image, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //w
        var widthConstraint = NSLayoutConstraint(item: Image, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        var heightConstraint = NSLayoutConstraint(item: Image, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        scrollView.addSubview(offLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: offLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: +20)
        //y
        verticalConstraint = NSLayoutConstraint(item: offLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: -5)
        //w
        widthConstraint = NSLayoutConstraint(item: offLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1/3, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: offLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 20)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        scrollView.addSubview(offTitleLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: offTitleLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: Image, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: offTitleLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: offTitleLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: offTitleLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 30)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        scrollView.addSubview(offMainTimeLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: offMainTimeLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: offTitleLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: offMainTimeLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: offMainTimeLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: offMainTimeLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 30)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        
        scrollView.addSubview(priceContainer)
        //x
        horizontalConstraint = NSLayoutConstraint(item: priceContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: offMainTimeLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        verticalConstraint = NSLayoutConstraint(item: priceContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: priceContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: priceContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 60)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        priceContainer.addSubview(AlPriceNumberLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: AlPriceNumberLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: priceContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: AlPriceNumberLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: priceContainer, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: AlPriceNumberLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: priceContainer, attribute: NSLayoutAttribute.width, multiplier: 1/2 , constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: AlPriceNumberLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: priceContainer, attribute: NSLayoutAttribute.height, multiplier: 1/2, constant: 0)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        priceContainer.addSubview(AlPriceLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: AlPriceLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: priceContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: AlPriceLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: AlPriceNumberLabel, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: AlPriceLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: priceContainer, attribute: NSLayoutAttribute.width, multiplier: 1/2 , constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: AlPriceLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: priceContainer, attribute: NSLayoutAttribute.height, multiplier: 1/2, constant: 0)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        priceContainer.addSubview(newPriceNumberLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: newPriceNumberLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: AlPriceNumberLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: newPriceNumberLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: priceContainer, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: newPriceNumberLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: priceContainer, attribute: NSLayoutAttribute.width, multiplier: 1/2 , constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: newPriceNumberLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: priceContainer, attribute: NSLayoutAttribute.height, multiplier: 1/2, constant: 0)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        

        
        priceContainer.addSubview(newPriceLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: newPriceLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: AlPriceLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: newPriceLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: newPriceNumberLabel, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: newPriceLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: priceContainer, attribute: NSLayoutAttribute.width, multiplier: 1/2 , constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: newPriceLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: priceContainer, attribute: NSLayoutAttribute.height, multiplier: 1/2, constant: 0)
        //90 == 3*header of section height + 15
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
}

extension StoreGoodModal
{
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
            
        }
    }
    
    @IBAction func deleteGood(_ sender: Any) {
        
        let alert = UIAlertController(title: "", message: "کالا حذف شود؟", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "بله", style: UIAlertActionStyle.default, handler: { action in
            switch action.style{
            case .default:
                
                self.deleteGood()
                break
                
            case .cancel:
                
                break
                
            case .destructive:
                
                break
            }
        }))
        
        alert.addAction(UIAlertAction(title: "خیر", style: UIAlertActionStyle.cancel, handler: { action in
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
    
    func deleteGood()
    {
        globalAlert.showWait("", subTitle: "لطفا صبور باشید...", closeButtonTitle: "", duration: 1000, colorStyle: 0x5065A1, colorTextButton: 0x000000, circleIconImage: nil, animationStyle: SCLAnimationStyle.bottomToTop)
        
        let soapMessage = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><DeleteGood xmlns=\"http://BuyApp.ir/\"><OffId>\(selectedGood.Id!)</OffId></DeleteGood></soap:Body></soap:Envelope>"
        
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
                        let mainDict1 = mainDict2.object(forKey: "DeleteGoodResponse") as! NSDictionary
                        let mainDict = mainDict1.object(forKey: "DeleteGoodResult") as! NSDictionary
                        
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
                                    if res["Result"] as! Int == 1
                                    {
                                        DispatchQueue.main.async {
                                            
                                            let alert = UIAlertController(title: "", message: "کالا حذف شد", preferredStyle: UIAlertControllerStyle.alert)
                                            
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
                                            
                                            let alert = UIAlertController(title: "خطای سرور", message: "کالا حذف نشد!", preferredStyle: UIAlertControllerStyle.alert)
                                            
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
                        else
                        {
                            
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
    
    @IBAction func editGood(_ sender: Any) {
        
        if ((selectedGood.offPercent as! Int == 0) || (selectedGood.mainTime! < 0)) //edit off
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mvc = storyboard.instantiateViewController(withIdentifier: "EditGood") as! EditGood
            mvc.isModalInPopover = true
            mvc.modalTransitionStyle = .coverVertical
            //mvc.good = selectedGood
            self.present(mvc, animated: true, completion: nil)
        }
        else //edit good
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mvc = storyboard.instantiateViewController(withIdentifier: "EditOff") as! EditOff
            mvc.isModalInPopover = true
            mvc.modalTransitionStyle = .coverVertical
            //mvc.good = selectedGood
            self.present(mvc, animated: true, completion: nil)
        }
    }
}
