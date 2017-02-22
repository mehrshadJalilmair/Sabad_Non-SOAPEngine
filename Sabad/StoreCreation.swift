//
//  StoreCreation.swift
//  Sabad
//
//  Created by Mehrshad JM on 2/20/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class StoreCreation: UIViewController {

    
    let ImagesContainer : UIView! = {
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        return filterView
    }()
    
    let NameContainer : UIView! = {
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        return filterView
    }()
    
    let ManagementContainer : UIView! = {
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        return filterView
    }()
    
    let PhoneContainer : UIView! = {
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        return filterView
    }()
    
    let DescriptionContainer : UIView! = {
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        return filterView
    }()
    
    let AddressContainer : UIView! = {
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        return filterView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        openGettingStoreFields = false
        //print(storeTwon)
        //print(storeMall)
    }
}

extension StoreCreation
{
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
            
        }
    }
    
    @IBAction func confirm(_ sender: Any) {//create store
        
        
    }
}
