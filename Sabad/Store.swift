//
//  Store.swift
//  Sabad
//
//  Created by Mehrshad Jalilmasir on 1/28/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import Foundation

class Store: NSObject {
    
    var stCode:AnyObject?
    var Id:AnyObject?
    var MallId:AnyObject?
    var stName:AnyObject?
    var stAddress:AnyObject?
    var stManager:AnyObject?
    var stDescription:AnyObject?
    var stTel:AnyObject?
    var stActive:AnyObject?
    var Mobile:AnyObject?
    var urlImage:AnyObject?
    var pm:AnyObject?
    var Followers:AnyObject?
    
    init(Id:AnyObject , stCode:AnyObject , MallId:AnyObject , stName:AnyObject , stAddress:AnyObject , stManager:AnyObject , stDescription:AnyObject , stTel:AnyObject , stActive:AnyObject, Mobile:AnyObject , urlImage:AnyObject , pm:AnyObject ,Followers:AnyObject)
    {
        self.stCode = stCode
        self.Id = Id
        self.MallId = MallId
        self.stName = stName
        self.stAddress = stAddress
        self.stManager = stManager
        self.stDescription = stDescription
        self.stTel = stTel
        self.stActive = stActive
        self.Mobile = Mobile
        self.urlImage = urlImage
        self.pm = pm
        self.Followers = Followers
        
        if self.Followers is NSNull {
            
            self.Followers = 0 as AnyObject?
        }
        
        if self.pm is NSNull {
            
            self.pm = "" as AnyObject?
        }
        
        if self.urlImage is NSNull {
            
            self.urlImage = "" as AnyObject?
        }
        
        if self.Mobile is NSNull {
            
            self.Mobile = "" as AnyObject?
        }
        
        if self.stTel is NSNull {
            
            self.stTel = "" as AnyObject?
        }
        
        if self.stActive is NSNull {
            
            self.stActive = 0 as AnyObject?
        }
        
        if self.stManager is NSNull {
            
            self.stManager = "" as AnyObject?
        }
        
        if self.stDescription is NSNull {
            
            self.stDescription = "" as AnyObject?
        }
        
        if self.stAddress is NSNull {
            
            self.stAddress = "" as AnyObject?
        }
        
        if self.stName is NSNull {
            
            self.stName = "" as AnyObject?
        }
        
        if self.MallId is NSNull {
            
            self.MallId = -1 as AnyObject?
        }
    }
}
