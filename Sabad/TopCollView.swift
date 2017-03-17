//
//  MostVisitedGoods.swift
//  Sabad
//
//  Created by Mehrshad JM on 2/2/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class TopCollView: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let cellId = "Item"
    let cellId0 = "Item0"
    
    var type:Int?
    {
        didSet{
            
            collectionView.reloadData()
            collectionView.scrollsToTop = true
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
        }
    }
    
    //collection view
    lazy var collectionView : UICollectionView! =
        {
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.sectionInset = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
            let width = ((SCREEN_SIZE.width) / 2) - 10
            let height = ((SCREEN_SIZE.width) / 2) + width/2 - 20
            layout.itemSize = CGSize(width: width, height: height)
            
            let collectionView : UICollectionView = UICollectionView(frame: self.contentView.frame, collectionViewLayout: layout)
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(GoodCell.self, forCellWithReuseIdentifier: self.cellId)
            collectionView.register(MallCell.self, forCellWithReuseIdentifier: self.cellId0)
            collectionView.backgroundColor = UIColor.white
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            return collectionView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(collectionView)
        
        //x
        let horizontalConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //y
        let verticalConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //w
        let widthConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        let heightConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        collectionView.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TopCollView
{
    //collView funcs
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        switch self.type! {
            
        case 0:
            return homeMallList.count
            
        case 1:
            return homeStoreList.count
            
        case 2:
            return homeGoodsList.count
            
        default:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GoodCell
        
        switch self.type! {
            
        case 0:
            let cell0 = collectionView.dequeueReusableCell(withReuseIdentifier: cellId0, for: indexPath) as! MallCell
            let mall  = homeMallList[indexPath.row]
            
            cell0.iconInTopRightView.image = UIImage(named: "ic_store_36pt")
            cell0.labelInTopRightView.text =  "\(mall.Stores!) فروشگاه"
            
            cell0.titleLabel.text = mall.MallName as! String?

            let address = NSString(string: (mall.MallAddress as! String?)!)
            
            cell0.addressLabel.text = address as String
            
            var image = ""
            if let nimage = mall.MallLogo
            {
                if(nimage is NSNull)
                {
                    image = "nedstark"
                    cell0.image.image = UIImage(named: image)
                }
                else
                {
                    if(nimage.contains("http"))
                    {
                        image = nimage as! String
                        cell0.image.loadImageUsingCacheWithUrlString(urlString: image)
                    }
                    else
                    {
                        image = "nedstark"
                        cell0.image.image = UIImage(named: image)
                    }
                }
            }
            else
            {
                image = "nedstark"
                cell0.image.image = UIImage(named: image)
            }
            
            if(goodsGoodList.count - 1 == indexPath.row)
            {
            }
            return cell0
            
        case 1:
            
            let store  = homeStoreList[indexPath.row]
            
            cell.iconInTopRightView.image = UIImage(named: "ic_touch_app_36pt")
            cell.labelInTopRightView.text =  "\(store.Followers!) دنبال کننده"
            
            cell.offLabel.isHidden = true
            cell.mainTimeLabel.isHidden = true
            
            cell.titleLabel.text = store.stName as! String?
            cell.alreadyPriceLabel.text = store.stDescription as! String?
            cell.newPriceLabel.text = store.stAddress as! String?
            
            var image = ""
            if let nimage = store.urlImage
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
            
            if(goodsGoodList.count - 1 == indexPath.row)
            {

            }
            return cell

        case 2:
            
            let good  = homeGoodsList[indexPath.row]
            
            cell.iconInTopRightView.image = UIImage(named: "ic_visibility_36pt")
            cell.labelInTopRightView.text =  "\(good.Views!) بازدید"
            
            cell.offLabel.text = "\(good.offPercent!) درصد    "
            cell.mainTimeLabel.text = "\(good.mainTime!) روز"
            cell.titleLabel.text = good.offTitle as! String?
            
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(good.offBeforePrice!) تومان")
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
            cell.alreadyPriceLabel.attributedText = attributeString
            
            let newPrice = (good.offBeforePrice as! Int)  - ((good.offBeforePrice as! Int) * (good.offPercent  as! Int) / 100)
            
            
            if ((good.offPercent as! Int == 0) || (good.mainTime! < 0))
            {
                cell.offLabel.isHidden = true
                cell.mainTimeLabel.isHidden = true
                cell.alreadyPriceLabel.text = "\(good.offBeforePrice!) تومان"
                cell.newPriceLabel.isHidden = true
            }
            else
            {
                cell.offLabel.isHidden = false
                cell.mainTimeLabel.isHidden = false
                cell.newPriceLabel.isHidden = false
                cell.newPriceLabel.text = "\(newPrice) تومان"
            }
            
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
            
            if(goodsGoodList.count - 1 == indexPath.row)
            {
            }
            return cell
            
        default:
            break
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch self.type! {
            
        case 0:
            
            let stores = homeMallList[indexPath.row].Stores as! Int
            
            if stores <= 0
            {
                return
            }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mvc = storyboard.instantiateViewController(withIdentifier: "MallModal") as! MallModal
            mvc.mall = homeMallList[indexPath.row]
            mvc.isModalInPopover = true
            mvc.modalTransitionStyle = .coverVertical
            
            storesInMall = [Store]()
            
            self.window?.rootViewController?.present(mvc, animated: true, completion: nil)
            break
            
            
        case 1:
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mvc = storyboard.instantiateViewController(withIdentifier: "StoreModal") as! StoreModal
            mvc.isModalInPopover = true
            mvc.modalTransitionStyle = .coverVertical
            mvc.store = homeStoreList[indexPath.row]
            
            self.window?.rootViewController?.present(mvc, animated: true, completion: nil)
            break
            
        case 2:
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mvc = storyboard.instantiateViewController(withIdentifier: "GoodModal") as! GoodModal
            mvc.isModalInPopover = true
            mvc.modalTransitionStyle = .coverVertical
            mvc.good = homeGoodsList[indexPath.row]
            
            self.window?.rootViewController?.present(mvc, animated: true, completion: nil)
            
            break
            
        default:
            break
        }
    }
}
