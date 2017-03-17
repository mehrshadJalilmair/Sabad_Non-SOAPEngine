//
//  setAbuse.swift
//  Sabad
//
//  Created by Mehrshad JM on 2/10/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit
import SCLAlertView

class setAbuseController: UIViewController , PopupContentViewController{

    var closeHandler: (() -> Void)?
    @IBOutlet weak var abuseTextField: UITextField!
    
    @IBOutlet weak var button: UIButton! {
        
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame.size = CGSize(width: SCREEN_SIZE.width ,height: SCREEN_SIZE.height/2)
    }
    
    class func instance() -> setAbuseController {
        
        let storyboard = UIStoryboard(name: "setAbuseController", bundle: nil)
        return storyboard.instantiateInitialViewController() as! setAbuseController
    }
    
    func sizeForPopup(_ popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        
        return CGSize(width: SCREEN_SIZE.width - 20 ,height: SCREEN_SIZE.height/2)
    }
    
    @IBAction func didTapConfirmButton(_ sender: AnyObject) {
        
        //closeHandler?()
        switch abuseType {
        case 0:
            
            self.setAbuse(id: abuseStore.Id as! Int, type: abuseType, description: self.abuseTextField.text!)
            break
            
        case 1:
            
            self.setAbuse(id: abuseGood.Id as! Int, type: abuseType, description: self.abuseTextField.text!)
            break
            
        default:
            break
        }
    }
    
    
    func setAbuse(id:Int , type: Int , description:String)
    {
        globalAlert.showWait("", subTitle: "لطفا صبور باشید...", closeButtonTitle: "", duration: 1000, colorStyle: 0x5065A1, colorTextButton: 0x000000, circleIconImage: nil, animationStyle: SCLAnimationStyle.bottomToTop)
        
        let soapMessage = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SetAbuse xmlns=\"http://BuyApp.ir/\"><id>\(id)</id><type>\(type)</type><description>\(description)</description></SetAbuse></soap:Body></soap:Envelope>"
        
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
            
            DispatchQueue.main.async
            {
                globalAlert.hideView()
            }
            
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
                        let mainDict1 = mainDict2.object(forKey: "SetAbuseResponse") as! NSDictionary
                        let mainDict = mainDict1.object(forKey: "SetAbuseResult") as! NSDictionary
                        
                        if mainDict.count > 0{
                            
                            let mainD = NSDictionary(dictionary: mainDict as [NSObject : AnyObject])
                            var cont = mainD["text"] as? String
                            cont = "{ \"content\" : " + cont! + "}"
                            
                            let data = (cont)?.data(using: .utf8)!
                            
                            guard let _result = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : AnyObject] else{
                                
                                return
                            }
                            
                            if let _ress = _result["content"] as? [AnyObject]
                            {
                                
                                for res in _ress
                                {
                                    if res["Result"] as! Int == 1
                                    {
                                        DispatchQueue.main.async {
                                            
                                            let alert = UIAlertController(title: "", message: "تخلف ثبت شد!", preferredStyle: UIAlertControllerStyle.alert)
                                            
                                            alert.addAction(UIAlertAction(title: "تایید", style: UIAlertActionStyle.default, handler: { action in
                                                switch action.style{
                                                case .default:
                                                    
                                                    self.closeHandler?()
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
                                        DispatchQueue.main.async
                                            {
                                                let alert = UIAlertController(title: "خطای سرور", message: "تخلف ثبت نشد!", preferredStyle: UIAlertControllerStyle.alert)
                                                
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
                DispatchQueue.main.async
                    {
                        let alert = UIAlertController(title: "خطای در دریافت", message: "تخلف ثبت نشد!", preferredStyle: UIAlertControllerStyle.alert)
                        
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
}
