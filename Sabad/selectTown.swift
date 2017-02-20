//
//  selectTown.swift
//  Sabad
//
//  Created by Mehrshad JM on 2/15/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class selectTown: UIViewController , UITableViewDataSource , UITableViewDelegate , UITextFieldDelegate{

    
    @IBOutlet weak var tableView: UITableView!
    let cellId = "listId"
    
    @IBOutlet var searchFor: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //tableView.register(selecTownTableViewCell.self, forCellReuseIdentifier: self.cellId)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTownList), name: NSNotification.Name(rawValue: "townListRecieved"), object: nil)
        
        if townList.count > 0 {
            
            
        }
        else
        {
            request.GetTownList()
        }
        
        townListCopy = townList
        searchFor.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func textFieldDidChange(_ textField: UITextField)
    {
        if textField.text! == "" {
            
            townList = townListCopy
        }
        else
        {
            townList = [Town]()
            for town in townListCopy {
                
                if (town.twName?.contains(textField.text!))! {
                    
                    townList.append(town)
                }
            }
        }
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        

        return townList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 53
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! selecTownTableViewCell
        
        cell.label.text = townList[indexPath.row].twName!
        cell.rightIcon.image = UIImage(named: "ic_refresh")
        cell.leftIcon.image = UIImage(named: "ic_refresh")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        twId = townList[indexPath.row].Id!
        twIdIndex = indexPath.row
        changeBannerAndList = true
        
        self.dismiss(animated: true) { 
            
            
        }
    }
}

extension selectTown
{
    func reloadTownList()
    {
        self.tableView.reloadData()
    }
    
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true) { 
            
            
        }
    }
}

class selecTownTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightIcon: UIImageView!
    @IBOutlet weak var leftIcon: UIImageView!
}
