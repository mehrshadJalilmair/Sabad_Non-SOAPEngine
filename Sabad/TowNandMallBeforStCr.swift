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
    @IBOutlet var bottomView: UIView!
    @IBOutlet var bottomLabel: UILabel!
    @IBOutlet var bottomBotton: UIButton!
    
    var whichList = 0 //0 == town list && 1 == mall list && 2 == arealist
    
    let cellId = "listId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storeTwon = -1
        storeMall = -1
        storeTwonIndex = -1
        inputName = ""
        inputAddress = ""
        
        self.view.bringSubview(toFront: tableView)
        
        self.tableView.keyboardDismissMode = .onDrag
        
        bottomBotton.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        //button.setImage(UIImage(named: "ic_refresh"), for: .normal)
        bottomBotton.tintColor = UIColor.white
        bottomBotton.layer.cornerRadius = 2
        bottomBotton.layer.masksToBounds = true
        bottomBotton.setTitleColor(UIColor.white, for: .normal)
        bottomBotton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        whichList = 0
        openGettingStoreFields = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTownList), name: NSNotification.Name(rawValue: "townListRecieved"), object: nil)
        
        searhFor.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        if townList.count == 0
        {
            request.GetTownList()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if closeAfterAddMallArea
        {
            self.dismiss(animated: true, completion: {
                
                closeAfterAddMallArea = false
            })
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
    
    @IBAction func addAreaOrMall(_ sender: Any) {
        

        print("here \(whichList)")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mvc = storyboard.instantiateViewController(withIdentifier: "AddMallArea") as! AddMallArea
        mvc.isModalInPopover = true
        mvc.modalTransitionStyle = .coverVertical
        mvc.whichType = self.whichList
        self.present(mvc, animated: true, completion: nil)
    }
    
    func reloadTownList()
    {
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
        }
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
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
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
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
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
            cell.rightIcon.image = UIImage(named: "ic_room_36pt")
            cell.leftIcon.image = UIImage(named: "moreinfo")
        }
        else //whichList == 1 || 2
        {
            //fatal error: Index out of range
            cell.label.text = townMallList[indexPath.row].MallName as! String?
            cell.rightIcon.image = UIImage(named: "ic_room_36pt")
            cell.leftIcon.image = UIImage(named: "moreinfo")
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
            
            DispatchQueue.main.async {
                
                let alert = UIAlertController(title: "", message: "آیا فروشگاه شما درون پاساژ ،بازار یا مجتمع قرار دارد؟", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "بله", style: UIAlertActionStyle.default, handler: { action in
                    switch action.style{
                    case .default:
                        
                        self.whichList = 1
                        
                        DispatchQueue.main.async {
                            
                            if storeTwon == -1 //remove botton view or add
                            {
                                self.changeLayout(removeBottomViewOrAdd: true)
                            }
                            else
                            {
                                self.topLabel.text = "مکانی که فروشگاه شما در آن قرار دارد را انتخاب کنید"
                                self.bottomBotton.setTitle("افزودن پاساژ", for: .normal)
                                self.bottomLabel.text = "اگر پاساژ،بازار یا مجتمع مربوط به فروشگاه شما در لیست بالا نیست،بازار یا مجتمع جدید اضافه کنید"
                                self.changeLayout(removeBottomViewOrAdd: false)
                            }
                            
                            townMallList.removeAll()
                            self.tableView.reloadData()
                        }
                        
                        self.GetTownMallList(TwId: storeTwon)
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
                        
                        
                        DispatchQueue.main.async {
                            
                            if storeTwon == -1
                            {
                                self.changeLayout(removeBottomViewOrAdd: true)
                            }
                            else
                            {
                                self.topLabel.text = "آدرس اصلی که فروشگاه شما در آن قرار دارد را انتخاب کنید"
                                self.bottomBotton.setTitle("افزودن محل", for: .normal)
                                self.bottomLabel.text = "چنانچه فروشگاه شما در آدرس های بالا موجود نیست،می توانید نام میدان یا خیابان اصلی را به لیست اضافه کنید"
                                self.changeLayout(removeBottomViewOrAdd: false)
                            }
                            
                            townMallList.removeAll()
                            self.tableView.reloadData()
                        }
                        
                        self.GetTownMallList(TwId: storeTwon)
                        break
                        
                    case .destructive:
                        
                        print("destructive")
                        break
                    }
                }))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
        else  //whichList == 1 || 2
        {
            DispatchQueue.main.async {
                
                self.topLabel.text = "انتخاب کنید"
                self.whichList = 0
                storeMall = townMallList[indexPath.row].Id as! Int
                townMallList = townMallListCopy
                self.searhFor.text = ""
                openGettingStoreFields = true
                self.dismiss(animated: true, completion: {
                    
                    
                })
            }
        }
    }
    
    func changeLayout(removeBottomViewOrAdd:Bool)// add area 1 == AddMallOrArea
    {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        if removeBottomViewOrAdd /// we dont need to add because twId = -1
        {
            let heightConstraint = NSLayoutConstraint(item: self.tableView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
            NSLayoutConstraint.activate([heightConstraint])
        }
        else
        {
            //h
            let heightConstraint = NSLayoutConstraint(item: self.tableView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: -self.bottomView.frame.size.height)
            NSLayoutConstraint.activate([heightConstraint])
        }
    }
    
    
    func GetTownMallList(TwId:Int)
    {
        let soapMessage = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><MallForFilter xmlns=\"http://BuyApp.ir/\"><twId>\(TwId)</twId></MallForFilter></soap:Body></soap:Envelope>"
        
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
                        
                        let mainDict3 = dictionaryData.object(forKey: "soap:Envelope") as! NSDictionary
                        let mainDict2 = mainDict3.object(forKey: "soap:Body") as! NSDictionary
                        let mainDict1 = mainDict2.object(forKey: "MallForFilterResponse") as! NSDictionary
                        let mainDict = mainDict1.object(forKey: "MallForFilterResult") as! NSDictionary
                        
                        if mainDict.count > 0{
                            
                            let mainD = NSDictionary(dictionary: mainDict as [NSObject : AnyObject])
                            var cont = mainD["text"] as? String
                            cont = "{ \"content\" : " + cont! + "}"
                            
                            let data = (cont)?.data(using: .utf8)!
                            
                            guard let _result = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : AnyObject] else{
                                
                                return
                            }
                            
                            if let _malls = _result["content"] as? [AnyObject]{
                                
                                townMallList = [Mall]()

                                for mall in _malls{
                                    
                                    if let actmall = mall as? [String : AnyObject]{
                                        
                                        let newmall = Mall(Id: actmall["Id"]!, twId: -1 as AnyObject , MallName: actmall["MallName"]!, MallDescription: "" as AnyObject , MallAddress: "" as AnyObject , MallTel: "" as AnyObject , MallLogo: "" as AnyObject , MallActive: false as AnyObject, IsMall: actmall["IsMall"]!, Stores: 0 as AnyObject)//Stores: actmall["Stores"]!)
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
                                        var Index = 0
                                        for item in townMallList
                                        {
                                            if item.IsMall as! Bool == true
                                            {
                                                townMallList.remove(at: Index)
                                            }
                                            else
                                            {
                                                Index += 1
                                            }
                                        }
                                    }
                                    townMallListCopy = townMallList
                                    
                                    DispatchQueue.main.async {
                                        
                                        self.tableView.reloadData()
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
                print("nil data")
            }
        }
        dataTask.resume()
    }
}
