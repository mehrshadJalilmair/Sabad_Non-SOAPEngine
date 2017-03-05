//
//  setAbuse.swift
//  Sabad
//
//  Created by Mehrshad JM on 2/10/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit
import MessageUI

class support: UIViewController, MFMailComposeViewControllerDelegate, PopupContentViewController ,UITextFieldDelegate{

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var phone: UITextField!
    @IBOutlet var message: UITextField!
    
    
    var closeHandler: (() -> Void)?
    
    @IBOutlet weak var button: UIButton! {
        
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame.size = CGSize(width: SCREEN_SIZE.width ,height: SCREEN_SIZE.height - 100)
        
        let tapGesture6 = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tapGesture6.cancelsTouchesInView = true
        scrollView.addGestureRecognizer(tapGesture6)
    }
    
    class func instance() -> support {
        
        let storyboard = UIStoryboard(name: "support", bundle: nil)
        return storyboard.instantiateInitialViewController() as! support
    }
    
    func sizeForPopup(_ popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        
        return CGSize(width: SCREEN_SIZE.width - 4 ,height: SCREEN_SIZE.height - 100)
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        
        sendEmail()
    }
    
    func sendEmail() {
        
        guard let message = message.text , let phone = phone.text else
        {
            return
        }
        
        if phone.characters.count < 11
        {
            return
        }
        
        if MFMailComposeViewController.canSendMail() {
            
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["Buy@cando.ir"])
            mail.setSubject(phone)
            mail.setMessageBody(message , isHTML: true)
            
            present(mail, animated: true)
            
        } else {
            
            print("cant send email")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        print(result)
    }
    
    @IBAction func back(_ sender: Any) {
        
        closeHandler?()
    }
    
    func hideKeyboard() {
        
        self.view.endEditing(true)
    }
}
