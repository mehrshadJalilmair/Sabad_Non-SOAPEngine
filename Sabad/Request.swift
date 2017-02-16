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
    
    func GetTownList() //check out all conditions
    {
        let soap = SOAPEngine()
        soap.userAgent = "SOAPEngine"
        soap.actionNamespaceSlash = true
        soap.version = SOAPVersion.VERSION_1_1
        soap.responseHeader = true
        
        soap.requestURL(Request.webServiceAddress,
                        soapAction: Request.getTownListAction,
                        completeWithDictionary: { (statusCode : Int,
                            dict : [AnyHashable : Any]?) -> Void in
                            
                            let result:Dictionary = dict! as Dictionary
                            let result1:NSDictionary = result[Array(result.keys)[0]]! as! NSDictionary
                            let result2:NSDictionary = result1["TownListResponse"] as! NSDictionary
                            var result3:String = result2["TownListResult"] as! String
                            
                            result3 = "{ \"content\" : " + result3 + "}"
                            let data = (result3).data(using: .utf8)!
                            
                            guard let _result = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : AnyObject] else{
                                
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
                            
        }) { (error : Error?) -> Void in
            
            print(error!)
        }
    }
}
