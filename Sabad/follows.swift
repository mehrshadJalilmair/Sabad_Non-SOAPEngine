//
//  follows.swift
//  Sabad
//
//  Created by Mehrshad JM on 2/15/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class follows: UIViewController , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource , UIScrollViewDelegate{

    var userId:Int?
    var getMoreGood = true
    
    let cellId1 = "collsearch"
    var Offset = 0
    
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
    
    @IBOutlet weak var topView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configCollectionView()

        followGoods = [Good]()
        userId = (defaults.value(forKey: "userId") as! Int)
        self.QueryOnDB(userId: self.userId!, Offset: self.Offset)
    }
    
    func configCollectionView()
    {
        view.addSubview(collectionView)
        
        //x
        let horizontalConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //y
        let verticalConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: topView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 1)
        //w
        let widthConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        let heightConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: SCREEN_SIZE.height - (self.topView.frame.size.height))
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
}

extension follows
{
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true) { 
            
            
        }
    }
    
    //collView funcs
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return followGoods.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId1, for: indexPath) as! GoodCell
        
        cell.topRightView.isHidden = true
        
        let good  = followGoods[indexPath.row]
        
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
        
        if(followGoods.count - 1 == indexPath.row)
        {
            print("s112")
            DispatchQueue.main.async {
                
                if self.getMoreGood
                {
                    self.Offset = followGoods.count
                    self.QueryOnDB(userId: self.userId! , Offset: self.Offset)
                }
            }
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mvc = storyboard.instantiateViewController(withIdentifier: "GoodModal") as! GoodModal
        mvc.isModalInPopover = true
        mvc.modalTransitionStyle = .coverVertical
        mvc.good = followGoods[indexPath.row]
        
        self.present(mvc, animated: true, completion: nil)
    }
    
    
    //get from web service
    func QueryOnDB(userId:Int , Offset:Int) //check out all conditions
    {
        let soap = SOAPEngine()
        soap.userAgent = "SOAPEngine"
        soap.actionNamespaceSlash = true
        soap.version = SOAPVersion.VERSION_1_1
        soap.responseHeader = true
        
        soap.setValue(userId, forKey: "userId")
        soap.setValue(Offset, forKey: "Offset")
        soap.requestURL(Request.webServiceAddress,
                        soapAction: Request.getFellowGoodsAction,
                        completeWithDictionary: { (statusCode : Int,
                            dict : [AnyHashable : Any]?) -> Void in
                            
                            let result:Dictionary = dict! as Dictionary
                            //print(result)
                            let result1:NSDictionary = result[Array(result.keys)[0]]! as! NSDictionary
                            let result2:NSDictionary = result1["GetFollowedGoodResponse"] as! NSDictionary
                            var result3:String = result2["GetFollowedGoodResult"] as! String
                            
                            result3 = "{ \"content\" : " + result3 + "}"
                            //print(result3)
                            let data = (result3).data(using: .utf8)!
                            
                            guard let _result = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : AnyObject] else{
                                
                                return
                            }
                            
                            if let _goods = _result["content"] as? [AnyObject]{
                                
                                
                                self.Offset == 0 ? followGoods = [Good]() : () //load more or not
                                
                                if _goods.count == 0
                                {
                                    self.getMoreGood = false
                                }
                                else
                                {
                                    self.getMoreGood = true
                                }
                                
                                for good in _goods{
                                    
                                    if let actgood = good as? [String : AnyObject]{
                                        
                                        let newgood = Good(Id: actgood["Id"]!, servicesId: actgood["servicesId"]!, offTitle: actgood["offTitle"]!, offPrImage: actgood["offPrImage"]!, offBeforePrice: actgood["offBeforePrice"]!, offPercent: actgood["offPercent"]!, offActive: actgood["offActive"]!, offDescription: actgood["offDescription"]!, offStartDate: actgood["offStartDate"]!, offEndDate: actgood["offEndDate"]!, offStartTime: actgood["offStartTime"]!, offEndTime: actgood["offEndTime"]!, Views: actgood["Views"]!)
                                        followGoods.append(newgood)
                                        
                                    }
                                }
                                self.collectionView.reloadData()
                                
                            }
                        
        }) { (error : Error?) -> Void in
            
            print(error!)
        }
    }
}

