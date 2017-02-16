//
//  Mall.swift
//  Sabad
//
//  Created by Mehrshad Jalilmasir on 1/28/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import Foundation

class Mall: NSObject {
    
    var twId:AnyObject?
    var Id:AnyObject?
    var MallName:AnyObject?
    var MallDescription:AnyObject?
    var MallAddress:AnyObject?
    var MallTel:AnyObject?
    var MallLogo:AnyObject?
    var MallActive:AnyObject?
    var IsMall:AnyObject?
    var Stores:AnyObject?
    
    init(Id:AnyObject , twId:AnyObject , MallName:AnyObject , MallDescription:AnyObject , MallAddress:AnyObject , MallTel:AnyObject , MallLogo:AnyObject , MallActive:AnyObject , IsMall:AnyObject, Stores:AnyObject)
    {
        self.Id = Id
        self.twId = twId
        self.MallName = MallName
        self.MallDescription = MallDescription
        self.MallAddress = MallAddress
        self.MallTel = MallTel
        self.MallLogo = MallLogo
        self.MallActive = MallActive
        self.IsMall = IsMall
        self.Stores = Stores
        
        if self.Stores is NSNull {
            
            self.Stores = 0 as AnyObject?
        }
        
        if self.IsMall is NSNull {
            
            self.IsMall = 0 as AnyObject?
        }
        
        if self.MallLogo is NSNull {
            
            self.MallLogo = "" as AnyObject?
        }
        
        if self.MallTel is NSNull {
            
            self.MallTel = "" as AnyObject?
        }
        
        if self.MallAddress is NSNull {
            
            self.MallAddress = "" as AnyObject?
        }
        
        if self.MallActive is NSNull {
            
            self.MallActive = 0 as AnyObject?
        }
        
        if self.twId is NSNull {
            
            self.twId = -1 as AnyObject?
        }
        
        if self.MallDescription is NSNull {
            
            self.MallDescription = "" as AnyObject?
        }
        
        if self.MallName is NSNull {
            
            self.MallName = "0" as AnyObject?
        }
    }
}
