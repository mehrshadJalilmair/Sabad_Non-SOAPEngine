//
//  tageds.swift
//  Sabad
//
//  Created by Mehrshad JM on 2/15/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class tageds: UIViewController , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource , UITableViewDelegate , UITableViewDataSource , UIScrollViewDelegate{

    
    //vars
    let cellId = "listId"
    let cellId1 = "collsearch"
    
    //views
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var switcher: UISegmentedControl!
    @IBOutlet weak var topView: UIView!
    
    //collection view
    lazy var collectionView : UICollectionView! =
        {
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
            let width = ((SCREEN_SIZE.width) / 2) - 10
            let height = ((SCREEN_SIZE.width) / 2) + width/2
            layout.itemSize = CGSize(width: width, height: height)
            
            let collectionView : UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(GoodCell.self, forCellWithReuseIdentifier: self.cellId1)
            collectionView.backgroundColor = UIColor.white
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SearchCell.self, forCellReuseIdentifier: self.cellId)
        tableView.separatorStyle = .none
        configCollectionView()
        self.collectionView.isHidden = true
        self.tableView.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        tagedGoods = [Good]()
        tagedStores = [Store]()
        
        for (key, value) in defaults.dictionaryRepresentation() {
            
            if key.contains("stId") {
                
                //print("\(key) = \(value)")
                /*fav_icon.setImage(UIImage(named: "favorite_set"), for: UIControlState.normal)
                defaults.set(self.store.Id, forKey: "stId\(self.store.Id!)")
                defaults.set(self.store.stName, forKey: "stName\(self.store.Id!)")
                defaults.set(self.store.MallId, forKey: "MallId\(self.store.Id!)")
                defaults.set(self.store.stTel, forKey: "stTel\(self.store.Id!)")
                defaults.set(self.store.stManager, forKey: "stManager\(self.store.Id!)")
                defaults.set(self.store.stDescription, forKey: "stDescription\(self.store.Id!)")
                defaults.set(self.store.stAddress, forKey: "stAddress\(self.store.Id!)")
                defaults.set(self.store.stCode, forKey: "stCode\(self.store.Id!)")
                defaults.set(self.store.Followers, forKey: "Followers\(self.store.Id!)")
                defaults.set(self.store.Mobile, forKey: "Mobile\(self.store.Id!)")
                defaults.set(self.store.stActive, forKey: "stActive\(self.store.Id!)")
                defaults.set(self.store.pm, forKey: "pm\(self.store.Id!)")
                defaults.set(self.store.urlImage, forKey: "urlImage\(self.store.Id!)")*/
                let newstore = Store(Id: value as AnyObject, stCode: defaults.value(forKey: "servicesId\(value)") as AnyObject, MallId: defaults.value(forKey: "MallId\(value)") as AnyObject, stName: defaults.value(forKey: "stName\(value)") as AnyObject, stAddress: defaults.value(forKey: "stAddress\(value)") as AnyObject, stManager: defaults.value(forKey: "stManager\(value)") as AnyObject, stDescription: defaults.value(forKey: "stDescription\(value)") as AnyObject, stTel: defaults.value(forKey: "stTel\(value)") as AnyObject, stActive: defaults.value(forKey: "stActive\(value)") as AnyObject, Mobile: defaults.value(forKey: "Mobile\(value)") as AnyObject, urlImage: defaults.value(forKey: "urlImage\(value)") as AnyObject, pm: defaults.value(forKey: "pm\(value)") as AnyObject, Followers: defaults.value(forKey: "Followers\(value)") as AnyObject)
                
                tagedStores.append(newstore)
                
            }
            else if key.contains("offId")
            {
                //print("\(key) = \(value)")
                
                //defaults.value(forKey: "offActive\(value)")
                let newgood = Good(Id: value as AnyObject,
                                   servicesId: defaults.value(forKey: "servicesId\(value)") as AnyObject,
                                   offTitle: defaults.value(forKey: "offTitle\(value)") as AnyObject,
                                   offPrImage: defaults.value(forKey: "offPrImage\(value)") as AnyObject,
                                   offBeforePrice: defaults.value(forKey: "offBeforePrice\(value)") as AnyObject,
                                   offPercent: defaults.value(forKey: "offPercent\(value)") as AnyObject,
                                   offActive: defaults.value(forKey: "offActive\(value)") as AnyObject,
                                   offDescription: defaults.value(forKey: "offDescription\(value)") as AnyObject,
                                   offStartDate: defaults.value(forKey: "offStartDate\(value)") as AnyObject,
                                   offEndDate: defaults.value(forKey: "offEndDate\(value)") as AnyObject,
                                   offStartTime: defaults.value(forKey: "offStartTime\(value)") as AnyObject,
                                   offEndTime: defaults.value(forKey: "offEndTime\(value)") as AnyObject,
                                   Views: defaults.value(forKey: "Views\(value)") as AnyObject)
                tagedGoods.append(newgood)
            }
        }
        self.tableView.reloadData()
        self.collectionView.reloadData()
    }
    
    func configCollectionView()
    {
        view.addSubview(collectionView)
        
        //x
        let horizontalConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //y
        let verticalConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: switcher, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +3)
        //w
        let widthConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        let heightConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: SCREEN_SIZE.height - (self.topView.frame.size.height) - switcher.frame.size.height)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
}

extension tageds
{
    @IBAction func changedIndex(_ sender: Any) {
        
        if (sender as! UISegmentedControl).selectedSegmentIndex == 0 {
            
            self.tableView.isHidden = false
            self.collectionView.isHidden = true
            self.tableView.reloadData()
        }
        else
        {
            self.tableView.isHidden = true
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true) { 
            
            
        }
    }
    
    //table view overrides
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tagedStores.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SearchCell
        
        var image = ""
        var name = ""
        var tell = ""
        var address = ""
        var imageType = 0
        
        if let nimage = tagedStores[indexPath.row].urlImage
        {
            if(nimage is NSNull)
            {
                image = "nedstark"
            }
            else
            {
                if(nimage.contains("http"))
                {
                    image = nimage as! String
                    imageType = 1
                }
                else
                {
                    image = "nedstark"
                }
            }
        }
        else
        {
            image = "nedstark"
        }
        name = tagedStores[indexPath.row].stName! as! String
        tell = tagedStores[indexPath.row].stTel! as! String
        address = tagedStores[indexPath.row].stAddress! as! String
        
        if(imageType == 0)
        {
            cell.cimage.image = UIImage(named: image)
        }
        else
        {
            cell.cimage.loadImageUsingCacheWithUrlString(urlString: image)
        }
        cell.nameLabel.text = name
        cell.tellLabel.text = tell
        cell.addLabel.text = address
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mvc = storyboard.instantiateViewController(withIdentifier: "StoreModal") as! StoreModal
        mvc.isModalInPopover = true
        mvc.modalTransitionStyle = .coverVertical
        mvc.store = tagedStores[indexPath.row]
        
        self.present(mvc, animated: true, completion: nil)
    }
    
    //collView funcs
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return tagedGoods.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId1, for: indexPath) as! GoodCell
        
        cell.topRightView.isHidden = true
        
        let good  = tagedGoods[indexPath.row]
        
        if ((good.offPercent as! Int == 0) || (good.mainTime! < 0))
        {
            cell.offLabel.isHidden = true
            cell.mainTimeLabel.isHidden = true
        }
        else
        {
            cell.offLabel.isHidden = false
            cell.mainTimeLabel.isHidden = false
        }
        
        cell.offLabel.text = "\(good.offPercent!) درصد    "
        cell.mainTimeLabel.text = "\(good.mainTime!) روز"
        cell.titleLabel.text = good.offTitle as! String?
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(good.offBeforePrice!)")
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
        cell.alreadyPriceLabel.attributedText = attributeString
        
        let newPrice = (good.offBeforePrice as! Int)  - ((good.offBeforePrice as! Int) * (good.offPercent  as! Int) / 100)
        cell.newPriceLabel.text = "\(newPrice)"
        
        var image = ""
        if let nimage = good.offPrImage
        {
            if(nimage is NSNull)
            {
                image = "nedstark"
                cell.image.image = UIImage(named: image)
            }
            else
            {
                if(nimage.contains("http"))
                {
                    image = nimage as! String
                    cell.image.loadImageUsingCacheWithUrlString(urlString: image)
                }
                else
                {
                    image = "nedstark"
                    cell.image.image = UIImage(named: image)
                }
            }
        }
        else
        {
            image = "nedstark"
            cell.image.image = UIImage(named: image)
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mvc = storyboard.instantiateViewController(withIdentifier: "GoodModal") as! GoodModal
        mvc.isModalInPopover = true
        mvc.modalTransitionStyle = .coverVertical
        mvc.good = tagedGoods[indexPath.row]
        
        self.present(mvc, animated: true, completion: nil)
    }
}
