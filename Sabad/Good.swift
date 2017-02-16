//
//  Good.swift
//  Sabad
//
//  Created by Mehrshad Jalilmasir on 1/29/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import Foundation

class Good: NSObject{
    
    var servicesId:AnyObject?
    var Id:AnyObject?
    var offTitle:AnyObject?
    var offPrImage:AnyObject?
    var offBeforePrice:AnyObject?
    var offPercent:AnyObject?
    var offActive:AnyObject?
    var offDescription:AnyObject?
    var offStartDate:AnyObject?
    var offEndDate:AnyObject?
    var offStartTime:AnyObject?
    var offEndTime:AnyObject?
    var Views:AnyObject?
    var mainTime:Int?
    
    init(Id:AnyObject , servicesId:AnyObject , offTitle:AnyObject , offPrImage:AnyObject , offBeforePrice:AnyObject , offPercent:AnyObject , offActive:AnyObject , offDescription:AnyObject , offStartDate:AnyObject, offEndDate:AnyObject , offStartTime:AnyObject , offEndTime:AnyObject , Views:AnyObject)
    {
        self.servicesId = servicesId
        self.Id = Id
        self.offTitle = offTitle
        self.offPrImage = offPrImage
        self.offBeforePrice = offBeforePrice
        self.offPercent = offPercent
        self.offActive = offActive
        self.offDescription = offDescription
        self.offStartDate = offStartDate
        self.offEndDate = offEndDate
        self.offStartTime = offStartTime
        self.offEndTime = offEndTime
        self.Views = Views
        
        
        if self.Views is NSNull {
            
            self.Views = 0 as AnyObject?
        }
        
        if self.offEndTime is NSNull {
            
            self.offEndTime = "" as AnyObject?
        }
        
        if self.offStartTime is NSNull {
            
            self.offStartTime = "" as AnyObject?
        }
        
        if self.offEndDate is NSNull {
            
            self.offEndDate = "" as AnyObject?
        }
        
        if self.offStartDate is NSNull {
            
            self.offStartDate = "" as AnyObject?
        }
        
        if self.offActive is NSNull {
            
            self.offActive = 0 as AnyObject?
        }
        
        if self.offPercent is NSNull {
            
            self.offPercent = 0 as AnyObject?
        }
        
        if self.offDescription is NSNull {
            
            self.offDescription = "" as AnyObject?
        }
        
        if self.offBeforePrice is NSNull {
            
            self.offBeforePrice = "0" as AnyObject?
        }
        
        if self.offPrImage is NSNull {
            
            self.offPrImage = "" as AnyObject?
        }
        
        if self.offTitle is NSNull {
            
            self.offTitle = "" as AnyObject?
        }
        
        //print(offStartDate)
        //print(offEndDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss a"
        //let _date1 = dateFormatter.date(from: self.offStartDate as! String)!
        let _date2 = dateFormatter.date(from: self.offEndDate as! String)! as NSDate
        
        let calendar = NSCalendar.current as NSCalendar
        let date1 = calendar.startOfDay(for: NSDate() as Date)
        let date2 = calendar.startOfDay(for: _date2 as Date)
        let flags = NSCalendar.Unit.day
        let components = calendar.components(flags, from: date1, to: date2)
            
        self.mainTime = components.day
    }
}
