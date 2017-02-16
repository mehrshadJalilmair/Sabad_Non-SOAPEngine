//
//  MallModal.swift
//  Sabad
//
//  Created by Mehrshad JM on 2/8/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class MallModal: UIViewController , UITableViewDelegate , UITableViewDataSource{


    @IBOutlet weak var tableView: UITableView!
    
    var mall:Mall!
    var Offset = 0
    var getMoreStore = true
    
    let cellId1:String = "tvCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(mall.Id!)
        tableView.separatorStyle = .none
        tableView.register(SearchCell.self, forCellReuseIdentifier: self.cellId1)
        QueryOnDB(MallId: self.mall.Id as! Int, Offset: self.Offset)
    }
    
    
    @IBAction func Back(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
            self.Offset = 0
            storesInMall = [Store]()
        }
    }
}

extension MallModal
{
    //get from web service
    func QueryOnDB(MallId:Int , Offset:Int) //check out all conditions
    {
        let soap = SOAPEngine()
        soap.userAgent = "SOAPEngine"
        soap.actionNamespaceSlash = true
        soap.version = SOAPVersion.VERSION_1_1
        soap.responseHeader = true
        
        soap.setValue(MallId, forKey: "MallId")
        soap.setValue(Offset, forKey: "Offset")
        soap.requestURL(Request.webServiceAddress,
                        soapAction: Request.storesInMallAction,
                        completeWithDictionary: { (statusCode : Int,
                            dict : [AnyHashable : Any]?) -> Void in
                            
                            let result:Dictionary = dict! as Dictionary
                            //print(result)
                            let result1:NSDictionary = result[Array(result.keys)[0]]! as! NSDictionary
                            let result2:NSDictionary = result1["StoreInMallResponse"] as! NSDictionary
                            var result3:String = result2["StoreInMallResult"] as! String
                            
                            //print(result3)
                            result3 = "{ \"content\" : " + result3 + "}"
                            let data = (result3).data(using: .utf8)!
                            
                            guard let _result = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : AnyObject] else{
                                
                                return
                            }
                            
                            if let _stores = _result["content"] as? [AnyObject]{
                                
                                Offset == 0 ? storesInMall = [Store]() : () //load more or not
                                
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
                                        storesInMall.append(newstore)
                                        
                                    }
                                }
                                self.tableView.reloadData()
                            }
        
        }) { (error : Error?) -> Void in
            
            print(error!)
        }
    }
    
    //tableView funcs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return storesInMall.count
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
        
        if let nimage = storesInMall[indexPath.row].urlImage
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
        name = storesInMall[indexPath.row].stName! as! String
        tell = storesInMall[indexPath.row].stTel! as! String
        address = storesInMall[indexPath.row].stAddress! as! String

        
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
        
        if(storesInMall.count - 1 == indexPath.row)
        {
            print("s12")
            DispatchQueue.main.async {
                
                if self.getMoreStore
                {
                    self.Offset = storesInMall.count
                    self.QueryOnDB(MallId: self.mall.Id as! Int, Offset: self.Offset)
                }
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mvc = storyboard.instantiateViewController(withIdentifier: "StoreModal") as! StoreModal
        mvc.isModalInPopover = true
        mvc.modalTransitionStyle = .coverVertical
        mvc.store = storesInMall[indexPath.row]
        self.present(mvc, animated: true, completion: nil)
    }
}



