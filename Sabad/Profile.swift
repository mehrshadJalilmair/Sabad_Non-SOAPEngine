//
//  Profile.swift
//  Sabad
//
//  Created by Mehrshad Jalilmasir on 1/25/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class Profile: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var numberOfSections:Int = 3
    var rowsTexts:[[String]] = [["همه شهرها" , "نشان شده ها" , "پیگیری های من"] , ["ثبت فروشگاه" , "فروشگاه های من"] , ["پشتیبانی سبد" , "درباره سبد"]]
    var rowsIcons:[[UIImage]] = [[#imageLiteral(resourceName: "ic_refresh") , #imageLiteral(resourceName: "ic_refresh") , #imageLiteral(resourceName: "ic_refresh")] , [#imageLiteral(resourceName: "ic_refresh") , #imageLiteral(resourceName: "ic_refresh")] , [#imageLiteral(resourceName: "ic_refresh") , #imageLiteral(resourceName: "ic_refresh")]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .none
        self.tableView.alwaysBounceVertical = false
        self.tableView.alwaysBounceHorizontal = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        tableView.reloadData()
        
        if openGettingStoreFields
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let mvc = storyboard.instantiateViewController(withIdentifier: "StoreCreation") as! StoreCreation
            mvc.isModalInPopover = true
            mvc.modalTransitionStyle = .coverVertical
            openGettingStoreFields = false
            self.present(mvc, animated: true, completion: nil)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rowsTexts[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell") as! profileCell
        cell.icon.image = rowsIcons[indexPath.section][indexPath.row]
        cell.Label.text = rowsTexts[indexPath.section][indexPath.row]
        
        if indexPath.section == 0 && indexPath.row == 0
        {
            if townList.count > 0 {
                
                cell.Label.text = "شهر \(townList[twIdIndex].twName!)"
            }
            else
            {
                cell.Label.text = "شهر تهران"
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
            
        case 0:

            if indexPath.row == 0{
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mvc = storyboard.instantiateViewController(withIdentifier: "selectTown") as! selectTown
                mvc.isModalInPopover = true
                mvc.modalTransitionStyle = .coverVertical
                
                self.present(mvc, animated: true, completion: nil)
            }
            else if indexPath.row == 1
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mvc = storyboard.instantiateViewController(withIdentifier: "tags") as! tageds
                mvc.isModalInPopover = true
                mvc.modalTransitionStyle = .coverVertical
                self.present(mvc, animated: true, completion: nil)
            }
            else if indexPath.row == 2
            {
                if defaults.value(forKey: "userId") != nil {
            
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let mvc = storyboard.instantiateViewController(withIdentifier: "follows") as! follows
                    mvc.isModalInPopover = true
                    mvc.modalTransitionStyle = .coverVertical
                    self.present(mvc, animated: true, completion: nil)
                }
                else
                {
                    return
                }
            }
            
            break
            
        case 1:
            
            if indexPath.row == 0{
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                let mvc = storyboard.instantiateViewController(withIdentifier: "TowNandMallBeforStCr") as! TowNandMallBeforStCr
                
                mvc.isModalInPopover = true
                mvc.modalTransitionStyle = .coverVertical
                openGettingStoreFields = false
                self.present(mvc, animated: true, completion: nil)
            }
            else if indexPath.row == 1{
             
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                
                let mvc = storyboard.instantiateViewController(withIdentifier: "UserStores") as! UserStores
                
                mvc.isModalInPopover = true
                mvc.modalTransitionStyle = .coverVertical
                openGettingStoreFields = false
                self.present(mvc, animated: true, completion: nil)
            }
            
            break
            
        case 2:

            if indexPath.row == 1
            {
                let popup = PopupController
                    .create(self)
                    .customize(
                        [
                            .layout(.center),
                            .animation(.fadeIn),
                            .backgroundStyle(.blackFilter(alpha: 0.8)),
                            .dismissWhenTaps(true),
                            .scrollable(true)
                        ]
                    )
                    .didShowHandler { popup in
                        print("showed popup!")
                    }
                    .didCloseHandler { popup in
                    
                }
                
                let container = aboutCanDo.instance()
                container.closeHandler = { _ in
                    popup.dismiss()
                }
                popup.show(container)
            }
            else
            {
                let popup = PopupController
                    .create(self)
                    .customize(
                        [
                            .layout(.center),
                            .animation(.fadeIn),
                            .backgroundStyle(.blackFilter(alpha: 0.8)),
                            .dismissWhenTaps(true),
                            .scrollable(true)
                        ]
                    )
                    .didShowHandler { popup in
                        print("showed popup!")
                    }
                    .didCloseHandler { popup in
                        
                }
                
                let container = support.instance()
                container.closeHandler = { _ in
                    popup.dismiss()
                }
                popup.show(container)
            }
            break
            
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 1.5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 40
    }
}

extension CGRect{
    init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat) {
        self.init(x:x,y:y,width:width,height:height)
    }
    
}
extension CGSize{
    init(_ width:CGFloat,_ height:CGFloat) {
        self.init(width:width,height:height)
    }
}
extension CGPoint{
    init(_ x:CGFloat,_ y:CGFloat) {
        self.init(x:x,y:y)
    }
}
