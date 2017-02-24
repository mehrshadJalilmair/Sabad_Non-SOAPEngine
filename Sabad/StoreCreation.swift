//
//  StoreCreation.swift
//  Sabad
//
//  Created by Mehrshad JM on 2/20/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class StoreCreation: UIViewController , UIScrollViewDelegate{

    @IBOutlet var scrollView: UIScrollView!
    
    let ImagesContainer : UIView! = {
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        filterView.backgroundColor = UIColor.red
        return filterView
    }()
    
    let NameContainer : UIView! = {
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        filterView.backgroundColor = UIColor.red
        return filterView
    }()
    
    let ManagementContainer : UIView! = {
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        filterView.backgroundColor = UIColor.red
        return filterView
    }()
    
    let PhoneContainer : UIView! = {
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        filterView.backgroundColor = UIColor.red
        return filterView
    }()
    
    let DescriptionContainer : UIView! = {
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        filterView.backgroundColor = UIColor.red
        return filterView
    }()
    
    let AddressContainer : UIView! = {
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        filterView.backgroundColor = UIColor.red
        return filterView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        openGettingStoreFields = false
        initImagesContainer()
        initNameContainer()
        initManagementContainer()
        initPhoneContainer()
        initDescriptionContainer()
        initAddressContainer()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        
        setScrollViewContentSize()
    }
    
    func setScrollViewContentSize() {
        
        var height: CGFloat
        
        let lastViewYPos = self.AddressContainer.frame.origin.y  // this is absolute positioning, not relative
        let lastViewHeight = self.AddressContainer.frame.size.height
        
        height = lastViewYPos + lastViewHeight + 5
    
        scrollView.contentSize.height = height
        
        scrollView.isUserInteractionEnabled = true
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    func initImagesContainer()
    {
        //let width = ((SCREEN_SIZE.width) / 2) - 10
        let height = ((SCREEN_SIZE.width) / 2)
        
        scrollView.addSubview(ImagesContainer)
        //x
        let horizontalConstraint = NSLayoutConstraint(item: ImagesContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //y
        let verticalConstraint = NSLayoutConstraint(item: ImagesContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: +5)
        //w
        let widthConstraint = NSLayoutConstraint(item: ImagesContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -10)
        //h
        let heightConstraint = NSLayoutConstraint(item: ImagesContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: height)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func initNameContainer()
    {
        scrollView.addSubview(NameContainer)
        //x
        let horizontalConstraint = NSLayoutConstraint(item: NameContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: ImagesContainer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        let verticalConstraint = NSLayoutConstraint(item: NameContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        let widthConstraint = NSLayoutConstraint(item: NameContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -10)
        //h
        let heightConstraint = NSLayoutConstraint(item: NameContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.height, multiplier: 1/6, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func initManagementContainer()
    {
        scrollView.addSubview(ManagementContainer)
        //x
        let horizontalConstraint = NSLayoutConstraint(item: ManagementContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: NameContainer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        let verticalConstraint = NSLayoutConstraint(item: ManagementContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        let widthConstraint = NSLayoutConstraint(item: ManagementContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -10)
        //h
        let heightConstraint = NSLayoutConstraint(item: ManagementContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.height, multiplier: 1/6, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func initPhoneContainer()
    {
        scrollView.addSubview(PhoneContainer)
        //x
        let horizontalConstraint = NSLayoutConstraint(item: PhoneContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: ManagementContainer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        let verticalConstraint = NSLayoutConstraint(item: PhoneContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        let widthConstraint = NSLayoutConstraint(item: PhoneContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -10)
        //h
        let heightConstraint = NSLayoutConstraint(item: PhoneContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.height, multiplier: 1/6, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func initDescriptionContainer()
    {
        scrollView.addSubview(DescriptionContainer)
        //x
        let horizontalConstraint = NSLayoutConstraint(item: DescriptionContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: PhoneContainer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        let verticalConstraint = NSLayoutConstraint(item: DescriptionContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        let widthConstraint = NSLayoutConstraint(item: DescriptionContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -10)
        //h
        let heightConstraint = NSLayoutConstraint(item: DescriptionContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.height, multiplier: 1/6, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func initAddressContainer()
    {
        scrollView.addSubview(AddressContainer)
        //x
        let horizontalConstraint = NSLayoutConstraint(item: AddressContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: DescriptionContainer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        let verticalConstraint = NSLayoutConstraint(item: AddressContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        let widthConstraint = NSLayoutConstraint(item: AddressContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -10)
        //h
        let heightConstraint = NSLayoutConstraint(item: AddressContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.height, multiplier: 1/6, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
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
