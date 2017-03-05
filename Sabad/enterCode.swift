//
//  enterCode.swift
//  Sabad
//
//  Created by Mehrshad JM on 3/5/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

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
        NameTextFieald.font = UIFont.systemFont(ofSize: 14)
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
            print("coding")
            guard let code = topTextField.text else {
                
                return
            }
            
            if code == signCode {
                
                defaults.set("loggined", forKey: "isLogin")
                defaults.set(_phone, forKey: "phone")
                self.dismiss(animated: true, completion: { 
                    
                    
                })
            }
        }
    }
    
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true) { 
            
            
        }
    }
    
    func SendSms(phone:String , code:String)
    {
        print(code)
        
        let soapMessage = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SendSms xmlns=\"http://BuyApp.ir/\"><Mobile>\(phone)</Mobile><Code>\(code)</Code></SendSms></soap:Body></soap:Envelope>"
        
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
                        
                        //let mainDict = dictionaryData.objectForKey("soap:Envelope")!.objectForKey("soap:Body")!.objectForKey("TownListResponse")!.objectForKey("TownListResult")   ?? NSDictionary()
                        let mainDict3 = dictionaryData.object(forKey: "soap:Envelope") as! NSDictionary
                        let mainDict2 = mainDict3.object(forKey: "soap:Body") as! NSDictionary
                        let mainDict1 = mainDict2.object(forKey: "SendSmsResponse") as! NSDictionary
                        let mainDict = mainDict1.object(forKey: "SendSmsResult") as! NSDictionary
                        
                        //print(mainDict1)
                        //print(mainDict)
                        
                        if mainDict.count > 0{
                            
                            let mainD = NSDictionary(dictionary: mainDict as [NSObject : AnyObject])
                            let cont = mainD["text"] as? String
                            //cont = "{ \"content\" : " + cont! + "}"
                            
                            //let data = (cont)?.data(using: .utf8)!
                            
                            if cont == ""
                            {
                                print("loggined")
                                DispatchQueue.main.async {
                                    
                                    self.page = pageType.code
                                    self.topLabel.text = "کد را وارد کنید"
                                    self.topTextField.placeholder = "۱۲۳۴۵"
                                    self.topTextField.text = ""
                                }
                            }
                            
                            /*guard let _result = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : AnyObject] else{
                             
                                return
                            }
                            
                            if let _ress = _result["content"] as? [AnyObject]{
                                
                                for res in _ress
                                {
                                    if res["Result"] as! String == " "
                                    {
                                        print("loggined")
                                        DispatchQueue.main.async {
                                            
                                            self.dismiss(animated: true, completion: {
                                                
                                                self.page = pageType.code
                                                self.topLabel.text = "کد را وارد کنید"
                                                self.topTextField.placeholder = "۱۲۳۴۵"
                                            })
                                        }
                                    }
                                    else if res["Result"] as! Int == 0
                                    {
                                        
                                    }
                                    else if res["Result"] as! Int == 1
                                    {
                                        DispatchQueue.main.async {
                                            
                                            self.dismiss(animated: true, completion: {
                                                
                                                
                                            })
                                        }
                                    }
                                }
                            }*/
                            
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
                print("nil data")
            }
        }
        dataTask.resume()
    }
}
