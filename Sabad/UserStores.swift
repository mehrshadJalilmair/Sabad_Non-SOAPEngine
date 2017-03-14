//
//  UserStores.swift
//  Sabad
//
//  Created by Mehrshad JM on 3/5/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class UserStores: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet var tableView: UITableView!
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var loginView: UIView!
    
    let cellId1:String = "tvCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SearchCell.self, forCellReuseIdentifier: self.cellId1)
        tableView.separatorStyle = .none
        
        if defaults.value(forKey: "isLogin") == nil {
            
            loginView.isHidden = false
        }
        else
        {
            loginView.isHidden = true
        }
        
        loginBtn.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        loginBtn.layer.cornerRadius = 3
        loginBtn.layer.masksToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if defaults.value(forKey: "isLogin") == nil {
            
            loginView.isHidden = false
        }
        else
        {
            loginView.isHidden = true
            let phone:String = defaults.value(forKey: "phone") as! String
            myStores(phone: phone)
        }
    }
}


extension UserStores
{
    @IBAction func back(_ sender: Any) {
        
        dismiss(animated: true) { 
            
            
        }
    }
    
    @IBAction func login(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mvc = storyboard.instantiateViewController(withIdentifier: "enterCode") as! enterCode
        mvc.isModalInPopover = true
        mvc.modalTransitionStyle = .coverVertical
        openGettingStoreFields = false
        self.present(mvc, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userStores.count
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
        
        if let nimage = userStores[indexPath.row].urlImage
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
        name = userStores[indexPath.row].stName! as! String
        tell = userStores[indexPath.row].stTel! as! String
        address = userStores[indexPath.row].stAddress! as! String
        
        
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
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mvc = storyboard.instantiateViewController(withIdentifier: "UserStore") as! UserStore
        mvc.isModalInPopover = true
        mvc.modalTransitionStyle = .coverVertical
        selectedStore = userStores[indexPath.row]
        self.present(mvc, animated: true, completion: nil)
    }
    
    func myStores(phone:String)
    {
        let soapMessage = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><MyStores xmlns=\"http://BuyApp.ir/\"><Mobile>\(phone)</Mobile></MyStores></soap:Body></soap:Envelope>"
        
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
                if let httpResponse = response as? HTTPURLResponse
                {
                    print(httpResponse.statusCode)
                    
                    var dictionaryData = NSDictionary()
                    
                    do
                    {
                        dictionaryData = try XMLReader.dictionary(forXMLData: data) as NSDictionary

                        let mainDict3 = dictionaryData.object(forKey: "soap:Envelope") as! NSDictionary
                        let mainDict2 = mainDict3.object(forKey: "soap:Body") as! NSDictionary
                        let mainDict1 = mainDict2.object(forKey: "MyStoresResponse") as! NSDictionary
                        let mainDict = mainDict1.object(forKey: "MyStoresResult") as! NSDictionary
                        
                        if mainDict.count > 0{
                            
                            let mainD = NSDictionary(dictionary: mainDict as [NSObject : AnyObject])
                            var cont = mainD["text"] as? String
                            cont = "{ \"content\" : " + cont! + "}"
                            
                            let data = (cont)?.data(using: .utf8)!
                            
                            guard let _result = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : AnyObject] else{
                             
                                return
                            }
                            if let _stores = _result["content"] as? [AnyObject]{
                                
                                //Offset == 0 ? searchStoreList = [Store]() : () //load more or not
                                
                                /*if _stores.count == 0
                                {
                                    self.getMoreStore = false
                                }
                                else
                                {
                                    self.getMoreStore = true
                                }*/
                                
                                if _stores.count > 0
                                {
                                    userStores = [Store]()
                                }
                                
                                for store in _stores{
                                    
                                    if let actstore = store as? [String : AnyObject]{
                                        
                                        let newstore = Store(Id: actstore["Id"]!, stCode: actstore["stCode"]!, MallId: actstore["MallId"]!, stName: actstore["stName"]!, stAddress: actstore["stAddress"]!, stManager: actstore["stManager"]!, stDescription: actstore["stDescription"]!, stTel: actstore["stTel"]!, stActive: actstore["stActive"]!, Mobile: actstore["Mobile"]!, urlImage: actstore["urlImage"]!, pm: actstore["pm"]!, Followers: actstore["Followers"]!)
                                        userStores.append(newstore)
                                        
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
                print("nil data")
            }
        }
        dataTask.resume()
    }
}

