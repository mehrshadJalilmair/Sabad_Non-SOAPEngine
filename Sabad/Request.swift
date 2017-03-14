//
//  Request.swift
//  Sabad
//
//  Created by Mehrshad Jalilmasir on 1/28/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class Request: NSObject {
    
    internal static let webServiceAddress:String = "http://94.182.4.13/sabad/ws3/buyapp.asmx"
    
    internal static let getTownListAction = "http://BuyApp.ir/TownList"
    internal static let getTownMallListAction = "http://BuyApp.ir/MallForFilter"
    internal static let searchAction = "http://BuyApp.ir/Search"
    internal static let goodsFilteringAction = "http://BuyApp.ir/GoodByFilter"
    internal static let getAdsImagesAction = "http://BuyApp.ir/AdvList"
    internal static let getHomeListAction = "http://BuyApp.ir/GetHomeList"
    internal static let storesInMallAction = "http://BuyApp.ir/StoreInMall"
    internal static let getStoreImagesAction = "http://BuyApp.ir/ImagesInStore"
    internal static let getStoreGoodsAction = "http://BuyApp.ir/GoodsInStore"
    internal static let setAbuseAction = "http://BuyApp.ir/SetAbuse"
    internal static let setFollowAction = "http://BuyApp.ir/SetFollow"
    internal static let getGoodAddressAction = "http://BuyApp.ir/AddressOfGood"
    internal static let gotoStoreAction = "http://BuyApp.ir/StoreOfGood"
    internal static let getFellowGoodsAction = "http://BuyApp.ir/GetFollowedGood"
    
    
    func GetTownList()
    {
        let soapMessage = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><TownList xmlns=\"http://BuyApp.ir/\" /></soap:Body></soap:Envelope>"
        
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
        
        print("start")
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
                        let mainDict1 = mainDict2.object(forKey: "TownListResponse") as! NSDictionary
                        let mainDict = mainDict1.object(forKey: "TownListResult") as! NSDictionary
                        
                        //print(mainDict1)
                        //print(mainDict)
                        
                        if mainDict.count > 0{
                            
                            let mainD = NSDictionary(dictionary: mainDict as [NSObject : AnyObject])
                            var cont = mainD["text"] as? String
                            cont = "{ \"content\" : " + cont! + "}"
                            
                            let data = (cont)?.data(using: .utf8)!
                            
                            guard let _result = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : AnyObject] else{
                                
                                return
                            }
                            
                            if let _towns = _result["content"] as? [AnyObject]{
                                
                                var newTown = Town(Id: -1 , twName: "همه شهرها" )
                                townList.append(newTown)
                                
                                for town in _towns{
                                    
                                    if let actTown = town as? [String : AnyObject]{
                                        
                                        newTown = Town(Id: actTown["Id"] as! Int, twName: actTown["twName"] as! String)
                                        townList.append(newTown)
                                    }
                                }
                            }
                            
                            if townList.count > 0
                            {
                                townListCopy = townList
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "townListRecieved") , object:nil)
                            }
                        }
                        else{
                            
                        }
                    }
                    catch
                    {
                        print("Your Dictionary value nil")
                    }
                }
            }
            else
            {
                print("nil data")
            }
        }
        dataTask.resume()
        
        print("end")
    }
}
