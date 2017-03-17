//
//  AddMallArea.swift
//  Sabad
//
//  Created by Mehrshad JM on 3/15/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit
import SCLAlertView

class AddMallArea: UIViewController {

    var whichType:Int!
    
    @IBOutlet var topView: UIView!
    
    let name: FloatLabelTextField! = {
        
        let NameTextFieald = FloatLabelTextField()
        NameTextFieald.font = UIFont.systemFont(ofSize: 10)
        NameTextFieald.textColor = UIColor.black
        NameTextFieald.textAlignment = .center
        NameTextFieald.placeholder = "۰۹۱۳۰۰۰۰۰۰۰"
        NameTextFieald.textAlignment = .center
        NameTextFieald.backgroundColor = UIColor.white
        NameTextFieald.tintColor = UIColor.red
        NameTextFieald.translatesAutoresizingMaskIntoConstraints = false
        return NameTextFieald
    }()
    
    let address: FloatLabelTextField! = {
        
        let NameTextFieald = FloatLabelTextField()
        NameTextFieald.font = UIFont.systemFont(ofSize: 10)
        NameTextFieald.textColor = UIColor.black
        NameTextFieald.textAlignment = .center
        NameTextFieald.placeholder = "۰۹۱۳۰۰۰۰۰۰۰"
        NameTextFieald.textAlignment = .center
        NameTextFieald.backgroundColor = UIColor.white
        NameTextFieald.tintColor = UIColor.red
        NameTextFieald.translatesAutoresizingMaskIntoConstraints = false
        return NameTextFieald
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        initView()
    }
    
    func initView()
    {
        self.view.addSubview(name)
        //x
        var horizontalConstraint = NSLayoutConstraint(item: name, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //y
        var verticalConstraint = NSLayoutConstraint(item: name, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: topView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //w
        var widthConstraint = NSLayoutConstraint(item: name, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.width, multiplier: 3/4, constant: 0)
        //h
        var heightConstraint = NSLayoutConstraint(item: name, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute , multiplier: 1, constant: 30)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        name.layer.cornerRadius = 3
        name.layer.masksToBounds = true
        name.titleYPadding = -2
        
        self.view.addSubview(address)
        //x
        horizontalConstraint = NSLayoutConstraint(item: address, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: address, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: name, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //w
        widthConstraint = NSLayoutConstraint(item: address, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.width, multiplier: 3/4, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: address, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute , multiplier: 1, constant: 30)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        address.layer.cornerRadius = 3
        address.layer.masksToBounds = true
        address.titleYPadding = -2
        
        if whichType == 1
        {
            name.placeholder = "نام پاساژ یا محدوده"
            address.placeholder = "آدرس پاساژ یا محدوده"
        }
        else if whichType == 2
        {
            name.placeholder = "آدرس اصلی،..."
            address.isHidden = true
        }
    }
}

extension AddMallArea
{
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
            closeAfterAddMallArea = false
        }
    }
    
    @IBAction func confirm(_ sender: Any) {
        
        
        if whichType == 1
        {
            if let address = address.text,let name = name.text
            {
                if address.characters.count > 0 && name.characters.count > 0
                {
                    addToServer(address:address , name:name)
                }
            }
        }
        else if whichType == 2
        {
            if let address = name.text
            {
                if address.characters.count > 0
                {
                    
                    addToServer(address:address , name:"")
                }
            }
        }
    }
    
    func addToServer(address:String , name:String)
    {
        globalAlert.showWait("", subTitle: "لطفا صبور باشید...", closeButtonTitle: "", duration: 1000, colorStyle: 0x5065A1, colorTextButton: 0x000000, circleIconImage: nil, animationStyle: SCLAnimationStyle.bottomToTop)
        
        let soapMessage = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><RequestMall xmlns=\"http://BuyApp.ir/\"><twId>\(storeTwon)</twId><name>\(name)</name><address>\(address)</address></RequestMall></soap:Body></soap:Envelope>"
        
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
                        let mainDict1 = mainDict2.object(forKey: "RequestMallResponse") as! NSDictionary
                        let mainDict = mainDict1.object(forKey: "RequestMallResult") as! NSDictionary
                        
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
                                            
                                            let alert = UIAlertController(title: "", message: "ثبت مکان جدید انجام شد", preferredStyle: UIAlertControllerStyle.alert)
                                            
                                            alert.addAction(UIAlertAction(title: "تایید", style: UIAlertActionStyle.default, handler: { action in
                                                switch action.style{
                                                case .default:
                                                    
                                                    if self.whichType == 1
                                                    {
                                                        inputAddress = "\(name)_\(address)"
                                                    }
                                                    else
                                                    {
                                                        inputAddress = "\(address)"
                                                    }
                                                    inputName = name
                                                    closeAfterAddMallArea = true
                                                    storeMall = 571
                                                    openGettingStoreFields = true
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
                                            
                                            let alert = UIAlertController(title: "خطای سرور", message: "ثبت مکان جدید انجام نشد", preferredStyle: UIAlertControllerStyle.alert)
                                            
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
            
            DispatchQueue.main.async {
                
                globalAlert.hideView()
            }
        }
        dataTask.resume()
    }
}
