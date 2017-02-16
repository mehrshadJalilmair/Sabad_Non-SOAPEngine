//
//  setAbuse.swift
//  Sabad
//
//  Created by Mehrshad JM on 2/10/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class setAbuseController: UIViewController , PopupContentViewController{

    var closeHandler: (() -> Void)?
    @IBOutlet weak var abuseTextField: UITextField!
    
    @IBOutlet weak var button: UIButton! {
        
        didSet {
            
            ///button.layer.borderColor = UIColor(red: 242/255, green: 105/255, blue: 100/255, alpha: 1.0).cgColor
            //button.layer.borderWidth = 1.5
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
    
    
    //get from web service
    func setAbuse(id:Int , type: Int , description:String) //check out all conditions
    {
        let soap = SOAPEngine()
        soap.userAgent = "SOAPEngine"
        soap.actionNamespaceSlash = true
        soap.version = SOAPVersion.VERSION_1_1
        soap.responseHeader = true
        
        soap.setValue(id, forKey: "id")
        soap.setValue(type, forKey: "type")
        soap.setValue(description, forKey: "description")
        soap.requestURL(Request.webServiceAddress,
                        soapAction: Request.setAbuseAction,
                        completeWithDictionary: { (statusCode : Int,
                            dict : [AnyHashable : Any]?) -> Void in
                            
                            let result:Dictionary = dict! as Dictionary
                            //print(result)
                            let result1:NSDictionary = result[Array(result.keys)[0]]! as! NSDictionary
                            let result2:NSDictionary = result1["SetAbuseResponse"] as! NSDictionary
                            var result3:String = result2["SetAbuseResult"] as! String
                            
                            result3 = "{ \"content\" : " + result3 + "}"
                            print(result3)
                            
                            let data = (result3).data(using: .utf8)!
                            
                            guard let _result = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : AnyObject] else{
                                
                                return
                            }
                            
                            if let _ress = _result["content"] as? [AnyObject]{
                                
                                for res in _ress
                                {
                                    if res["Result"] as! Int == 0
                                    {
                                        
                                    }
                                    else if res["Result"] as! Int == 1
                                    {
                                        self.closeHandler?()
                                    }
                                }
                            }
                            
        }) { (error : Error?) -> Void in
            
            print(error!)
        }
    }
}
