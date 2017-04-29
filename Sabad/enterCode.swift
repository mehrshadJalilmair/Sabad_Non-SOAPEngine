//
//  enterCode.swift
//  Sabad
//
//  Created by Mehrshad JM on 3/5/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit
import SCLAlertView

class enterCode: UIViewController {

    enum pageType {
        case phone
        case code
    }
    var page = pageType.phone
    
    var signCode = ""
    var _phone = ""
    
    @IBOutlet var topLabel: UILabel!
    
    let topTextField: FloatLabelTextField! = {
        
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
        
        self.view.addSubview(topTextField)
        //x
        let horizontalConstraint = NSLayoutConstraint(item: topTextField, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //y
        let verticalConstraint = NSLayoutConstraint(item: topTextField, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: topLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //w
        let widthConstraint = NSLayoutConstraint(item: topTextField, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.width, multiplier: 3/4, constant: 0)
        //h
        let heightConstraint = NSLayoutConstraint(item: topTextField, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute , multiplier: 1, constant: 30)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        topTextField.layer.cornerRadius = 3
        topTextField.layer.masksToBounds = true
        topTextField.titleYPadding = -2
    }
}

extension enterCode
{
    @IBAction func confirm(_ sender: Any)
    {
        if page == pageType.phone
        {
            let ranNumber:Int = Int(arc4random_uniform(10000)) + 10000
            signCode = String(ranNumber)
            
            guard let phone = topTextField.text else {
                
                return
            }
            
            if phone.characters.count < 11 {
                
                return
            }
            _phone = phone
            self.SendSms(phone: _phone, code: signCode)
        }
        else
        {
            guard let code = topTextField.text else {
                
                return
            }
            
            if code == signCode {
                
                defaults.set("loggined", forKey: "isLogin")
                defaults.set(_phone, forKey: "phone")
                self.dismiss(animated: true, completion: { 
                    
                    
                })
            }
            else
            {
                
            }
        }
    }
    
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true) { 
            
            
        }
    }
    
    func SendSms(phone:String , code:String)
    {
        
        globalAlert.showWait("", subTitle: "لطفا صبور باشید...", closeButtonTitle: "", duration: 1000, colorStyle: 0x5065A1, colorTextButton: 0x000000, circleIconImage: nil, animationStyle: SCLAnimationStyle.bottomToTop)
        
        var phone:String = phone.replacingOccurrences(of: "۰", with: "0")
        phone = phone.replacingOccurrences(of: "۹", with: "9")
        phone = phone.replacingOccurrences(of: "۸", with: "8")
        phone = phone.replacingOccurrences(of: "۷", with: "7")
        phone = phone.replacingOccurrences(of: "۶", with: "6")
        phone = phone.replacingOccurrences(of: "۵", with: "5")
        phone = phone.replacingOccurrences(of: "۴", with: "4")
        phone = phone.replacingOccurrences(of: "۳", with: "3")
        phone = phone.replacingOccurrences(of: "۲", with: "2")
        phone = phone.replacingOccurrences(of: "۱", with: "1")
        
        var code:String = code.replacingOccurrences(of: "۰", with: "0")
        code = code.replacingOccurrences(of: "۹", with: "9")
        code = code.replacingOccurrences(of: "۸", with: "8")
        code = code.replacingOccurrences(of: "۷", with: "7")
        code = code.replacingOccurrences(of: "۶", with: "6")
        code = code.replacingOccurrences(of: "۵", with: "5")
        code = code.replacingOccurrences(of: "۴", with: "4")
        code = code.replacingOccurrences(of: "۳", with: "3")
        code = code.replacingOccurrences(of: "۲", with: "2")
        code = code.replacingOccurrences(of: "۱", with: "1")
        
        let soapMessage = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SendSms xmlns=\"http://BuyApp.ir/\"><Mobile>\(phone)</Mobile><Code>\(code)</Code></SendSms></soap:Body></soap:Envelope>"
        
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
                        let mainDict1 = mainDict2.object(forKey: "SendSmsResponse") as! NSDictionary
                        let mainDict = mainDict1.object(forKey: "SendSmsResult") as! NSDictionary
                        
                        if mainDict.count > 0{
                            
                            let mainD = NSDictionary(dictionary: mainDict as [NSObject : AnyObject])
                            let cont = mainD["text"] as? String
                            
                            if cont == ""
                            {
                                DispatchQueue.main.async {
                                    
                                    self.page = pageType.code
                                    self.topLabel.text = "کد را وارد کنید"
                                    self.topTextField.placeholder = "۱۲۳۴۵"
                                    self.topTextField.text = ""
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
