//
//  Ads.swift
//  Sabad
//
//  Created by Mehrshad JM on 2/2/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import Foundation


class Ad: NSObject{
    
    var advImageUrl:AnyObject?
    var advText:AnyObject?
    var _Type:AnyObject?
    var Address:AnyObject?

    init(advImageUrl:AnyObject , advText:AnyObject , _Type:AnyObject , Address:AnyObject)
    {
        self.advImageUrl = advImageUrl
        self.advText = advText
        self._Type = _Type
        self.Address = Address
        
        if self.advImageUrl is NSNull {
            
            self.advImageUrl = "" as AnyObject?
        }
        
        if self.advText is NSNull {
            
            self.advText = "" as AnyObject?
        }
        
        if self._Type is NSNull {
            
            self._Type = -1 as AnyObject?
        }
        
        if self.Address is NSNull {
            
            self.Address = "" as AnyObject?
        }
    }
}
