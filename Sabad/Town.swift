//
//  Town.swift
//  Sabad
//
//  Created by Mehrshad Jalilmasir on 1/28/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import Foundation

class Town: NSObject
{
    var Id:Int?
    var twName:String?
    
    init(Id:Int , twName:String)
    {
        self.Id = Id
        self.twName = twName
    }
}
