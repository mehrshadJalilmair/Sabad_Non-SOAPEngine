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
    
    //let container: UIView = UIView()
    
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
            
            break
            
        case 2:

            if indexPath.row == 1
            {
                let popup = PopupController
                    .create(self)
                    .customize(
                        [
                            .layout(.top),
                            .animation(.slideDown),
                            .scrollable(false),
                            .dismissWhenTaps(false),
                            .backgroundStyle(.blackFilter(alpha: 0))
                        ]
                    )
                    .didShowHandler { popup in
                        print("showed popup!")
                        
                    }
                    .didCloseHandler { _ in
                        
                        print("closed popup!")
                }
                //print(actad)
                let container = aboutCanDo.instance()
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
    /*func about(uiView : UIView)
    {
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColor(red: CGFloat(0xFF)/255, green: CGFloat(0xFF)/255, blue: CGFloat(0xFF)/255, alpha: 0.5)
     
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(0, 0, uiView.frame.size.width - 100 , uiView.frame.size.height/2)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor(red: CGFloat(0x44)/255, green: CGFloat(0x44)/255, blue: CGFloat(0x44)/255, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd: UILabel = UILabel()
        actInd.frame = CGRect(0.0, 0.0, uiView.frame.size.width - 100 , uiView.frame.size.height/2);
        actInd.text = "salam"
        actInd.textColor = UIColor.white
        actInd.textAlignment = .center
        actInd.center = CGPoint(loadingView.frame.size.width / 2,
                                    loadingView.frame.size.height / 2)
        
        let close: UIButton = UIButton()
        close.frame = CGRect(0.0, 0.0, 40.0 , 40.0);
        close.center = CGPoint(loadingView.frame.size.width - 20,
                                 20)
        //close.setTitle("بستن", for: UIControlState.normal)
        close.setImage(UIImage(named: "ic_delete_forever_white"), for: UIControlState.normal)
        close.addTarget(self, action: #selector(closeing), for: UIControlEvents.touchUpInside)
        
        loadingView.addSubview(close)
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        uiView.addSubview(container)
    }*/
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
