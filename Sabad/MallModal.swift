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
    func QueryOnDB(MallId:Int , Offset:Int)
    {
        let soapMessage =
        "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><StoreInMall xmlns=\"http://BuyApp.ir/\"><MallId>\(MallId)</MallId><Offset>\(Offset)</Offset></StoreInMall></soap:Body></soap:Envelope>"
        
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
                        let mainDict1 = mainDict2.object(forKey: "StoreInMallResponse") as! NSDictionary
                        let mainDict = mainDict1.object(forKey: "StoreInMallResult") as! NSDictionary
                        
                        if mainDict.count > 0{
                            
                            let mainD = NSDictionary(dictionary: mainDict as [NSObject : AnyObject])
                            var cont = mainD["text"] as? String
                            cont = "{ \"content\" : " + cont! + "}"
                            
                            let data = (cont)?.data(using: .utf8)!
                            
                            guard let _result = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : AnyObject] else{
                                
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
            }
        }
        dataTask.resume()
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



