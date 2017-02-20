//
//  StoreCreation.swift
//  Sabad
//
//  Created by Mehrshad JM on 2/20/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class StoreCreation: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        openGettingStoreFields = false
    }
}

extension StoreCreation
{
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
            
        }
    }
}
