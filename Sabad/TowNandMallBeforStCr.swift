//
//  TowNandMallBeforStCr.swift
//  Sabad
//
//  Created by Mehrshad JM on 2/20/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class TowNandMallBeforStCr: UIViewController , UITableViewDelegate , UITableViewDataSource{

    
    @IBOutlet var searhFor: UITextField!
    @IBOutlet var topLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var whichList = 0 //0 == town list && 1 == mall list && 2 == arealist
    
    let cellId = "listId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storeTwon = -1
        storeMall = -1
        storeTwonIndex = -1
        
        whichList = 0
        openGettingStoreFields = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTownList), name: NSNotification.Name(rawValue: "townListRecieved"), object: nil)
        
        searhFor.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        if townList.count == 0
        {
            request.GetTownList()
        }
    }
}

extension TowNandMallBeforStCr
{
    @IBAction func back(_ sender: Any) {
        
        dismiss(animated: true) { 
            
            openGettingStoreFields = false
        }
    }
    
    func reloadTownList()
    {
        tableView.reloadData()
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        
        if whichList == 0
        {
            if textField.text! == "" {
                
                townList = townListCopy
            }
            else
            {
                townList = [Town]()
                for town in townListCopy {
                    
                    if (town.twName?.contains(textField.text!))! {
                        
                        townList.append(town)
                    }
                }
            }
            self.tableView.reloadData()
        }
        else //whichList == 1 || 2
        {
            if textField.text! == "" {
                
                townMallList = townMallListCopy
            }
            else
            {
                townMallList = [Mall]()
                for mall in townMallListCopy {
                    
                    if (mall.MallName?.contains(textField.text!))! {
                        
                        townMallList.append(mall)
                    }
                }
            }
            self.tableView.reloadData()
        }
    }
    
    
    //table view funcs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if whichList == 0 {
            
            return townList.count
        }
        //whichList == 1 || 2
        return townMallList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FilterTableViewCell
        if whichList == 0 {
            
            cell.label.text = townList[indexPath.row].twName
            cell.rightIcon.image = UIImage(named: "ic_refresh")
            cell.leftIcon.image = UIImage(named: "ic_refresh")
        }
        else //whichList == 1 || 2
        {
            cell.label.text = townMallList[indexPath.row].MallName as! String?
            cell.rightIcon.image = UIImage(named: "ic_refresh")
            cell.leftIcon.image = UIImage(named: "ic_refresh")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if whichList == 0
        {
            storeTwonIndex = indexPath.row
            storeTwon = townList[indexPath.row].Id!
            townList = townListCopy
            searhFor.text = ""
            
            let alert = UIAlertController(title: "", message: "آیا فروشگاه شما درون پاساژ ،بازار یا مجتمع قرار دارد؟", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "بله", style: UIAlertActionStyle.default, handler: { action in
                switch action.style{
                case .default:
                    
                    self.whichList = 1
                    self.GetTownMallList(TwId: selectedTownId)
                    print("default")
                    break
                    
                case .cancel:
                    
                    print("cancel")
                    break
                    
                case .destructive:
                    
                    print("destructive")
                    break
                }
            }))
                
            alert.addAction(UIAlertAction(title: "خیر", style: UIAlertActionStyle.cancel, handler: { action in
                switch action.style{
                case .default:
                    
                    print("default")
                    break
                    
                case .cancel:
                    
                    print("cancel")
                    
                    self.whichList = 2
                    self.GetTownMallList(TwId: selectedTownId)
                    break
                    
                case .destructive:
                    
                    print("destructive")
                    break
                }
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        else  //whichList == 1 || 2
        {
            topLabel.text = "انتخاب کنید"
            whichList = 0
            storeMall = townMallList[indexPath.row].Id as! Int
            townMallList = townMallListCopy
            searhFor.text = ""
            openGettingStoreFields = true
            self.dismiss(animated: true, completion: {
                
                
            })
        }
    }
    
    func GetTownMallList(TwId:Int) //check out all conditions
    {
        let soap = SOAPEngine()
        soap.userAgent = "SOAPEngine"
        soap.actionNamespaceSlash = true
        soap.version = SOAPVersion.VERSION_1_1
        soap.responseHeader = true
        
        soap.setValue(TwId, forKey: "twId")
        soap.requestURL(Request.webServiceAddress,
                        soapAction: Request.getTownMallListAction,
                        completeWithDictionary: { (statusCode : Int,
                            dict : [AnyHashable : Any]?) -> Void in
                            
                            let result:Dictionary = dict! as Dictionary
                            //print(result)
                            let result1:NSDictionary = result[Array(result.keys)[0]]! as! NSDictionary
                            let result2:NSDictionary = result1["MallForFilterResponse"] as! NSDictionary
                            var result3:String = result2["MallForFilterResult"] as! String
                            
                            result3 = "{ \"content\" : " + result3 + "}"
                            let data = (result3).data(using: .utf8)!
                            
                            guard let _result = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : AnyObject] else{
                                
                                return
                            }
                            
                            if let _malls = _result["content"] as? [AnyObject]{
                                
                                townMallList = [Mall]()
                                var newmall = Mall(Id: -1 as AnyObject, twId: -1 as AnyObject , MallName: "همه پاساژها و محدوده ها" as AnyObject, MallDescription: "" as AnyObject , MallAddress: "" as AnyObject , MallTel: "" as AnyObject , MallLogo: "" as AnyObject , MallActive: false as AnyObject, IsMall: true as AnyObject , Stores:0 as AnyObject)
                                townMallList.append(newmall)
                                for mall in _malls{
                                    
                                    if let actmall = mall as? [String : AnyObject]{
                                        
                                        newmall = Mall(Id: actmall["Id"]!, twId: -1 as AnyObject , MallName: actmall["MallName"]!, MallDescription: "" as AnyObject , MallAddress: "" as AnyObject , MallTel: "" as AnyObject , MallLogo: "" as AnyObject , MallActive: false as AnyObject, IsMall: actmall["IsMall"]!, Stores: 0 as AnyObject)//Stores: actmall["Stores"]!)
                                        townMallList.append(newmall)
                                    }
                                }
                                if townMallList.count > 0
                                {
                                    townMallListCopy = townMallList
                                    if self.whichList == 1
                                    {
                                        //ok-no problem
                                    }
                                    else if self.whichList == 2
                                    {
                                        //poplulate array form isMall = 0
                                    }
                                    //self.whichList = 1
                                    self.tableView.reloadData()
                                }
                            }
                            
        }) { (error : Error?) -> Void in
            
            print(error!)
        }
    }
}
